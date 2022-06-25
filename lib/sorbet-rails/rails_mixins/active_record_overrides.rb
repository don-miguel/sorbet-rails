# typed: false

require 'singleton'

class ActiveRecordOverrides
  include Singleton

  attr_reader :enum_calls

  def initialize
    @enum_calls = {}
  end

  def store_enum_call(klass, kwargs)
    class_name = klass.name
    @enum_calls[class_name] ||= {}
    # modeling the logic in
    # https://github.com/rails/rails/blob/master/activerecord/lib/active_record/enum.rb#L152
    kwargs.each do |name, _values|
      next if ::ActiveRecord::Enum::SR_ENUM_KEYWORDS.include?(name)

      # calling dup is required, because Rails internally mutates `kwargs` (the args you passed to `enum`)
      @enum_calls[class_name][name] = kwargs.dup
    end
  end

  def get_enum_call(klass, enum_sym)
    return nil if klass == Object

    class_name = klass.name
    class_enum_calls = @enum_calls[klass.name]
    return class_enum_calls[enum_sym] if class_enum_calls && class_enum_calls.has_key?(enum_sym)

    get_enum_call(klass.superclass, enum_sym)
  end
end

class SorbetRails::TypedEnumConfig < T::Struct
  # set the method to be true or false
  const :strict_mode, T::Boolean
  const :class_name, String
end

module ::ActiveRecord::Enum
  extend T::Sig
  include Kernel

  alias old_enum enum

  SR_ENUM_KEYWORDS = [
    # keywords from https://github.com/rails/rails/blob/master/activerecord/lib/active_record/enum.rb
    :_prefix,
    :_suffix,
    :_scopes,
    :_default
  ]

  def self.extended(base) # :nodoc:
    base.class_attribute(:defined_enums, instance_writer: false, default: {})
  end

  def inherited(base) # :nodoc:
    base.defined_enums = defined_enums.deep_dup
    super
  end

  sig { params(definitions: T::Hash[Symbol, T.untyped]).void }
  def _define_enum(definitions)
    names = definitions.keys - SR_ENUM_KEYWORDS

    if names.size != 1
      raise MultipleEnumsDefinedError, "typed_enum only supports 1 enum defined at a time,
        given #{names.count}: #{names.join(', ')}".squish!
    end
    ActiveRecordOverrides.instance.store_enum_call(self, definitions)
    old_enum(**definitions)
  end

  sig do
    params(name: T.any(Symbol, String),
           values: T.any(T::Hash[T.any(String, Symbol), T.any(Integer, String, Symbol)], T::Array[Symbol]), options: T.untyped).void
  end
  def _define_named_enum(name, values, **options)
    ActiveRecordOverrides.instance.store_enum_call(self, { name => values, **options })
    old_enum(name, values, **options.transform_keys { |key| :"#{key[1..-1]}" })
  end

  sig do
    params(name: T.untyped, values: T.nilable(T.any(T::Hash[T.any(String, Symbol), T.any(Integer, String, Symbol)], T::Array[Symbol])),
           options: T.untyped).void
  end
  def enum(name = nil, values = nil, **options)
    if name
      # New rails 7 syntax
      unless values
        values = options
        options = {}
      end
      _define_enum({ name => values, **options })
      return _define_typed_enum(name, values, **options)
    end
    _define_enum(options)
    options.each do |name, values|
      # skip irrelevant keywords
      next if SR_ENUM_KEYWORDS.include?(name)

      _define_typed_enum(name, values, **options.slice(SR_ENUM_KEYWORDS))
    rescue ArgumentError, ConflictTypedEnumNameError, TypeError => e
      # known errors
      # do nothing if we cannot define t_enum
      puts "warning: #{e.message}"
    rescue StandardError => e
      # rescue any other kind of error to unblock the application
      # can be disabled in development
      puts "warning: #{e.message}"
      # raise ex
    end
  end

  sig { params(definitions: T::Hash[Symbol, T.untyped]).void }
  def typed_enum(definitions)
    names = definitions.keys - SR_ENUM_KEYWORDS

    if names.size != 1
      raise MultipleEnumsDefinedError, "typed_enum only supports 1 enum defined at a time,
        given #{names.count}: #{names.join(', ')}".squish!
    end

    name = names[0]

    _define_enum(definitions)

    _define_typed_enum(
      T.must(name),
      definitions[name],
      strict_mode: true
    )
  end

  # this config is for sorbet-rails to inflect on the settings
  sig { returns(T::Hash[String, SorbetRails::TypedEnumConfig]) }
  def typed_enum_reflections
    @typed_enum_reflections ||= {}
  end

  sig do
    params(
      name: Symbol,
      values: T.untyped,
      prefix: T.any(Symbol, T::Boolean),
      suffix: Symbol,
      scopes: T::Boolean,
      strict_mode: T::Boolean,
      _options: T.untyped
    )
      .void
  end
  def _define_typed_enum(
    name,
    values,
    prefix: nil, suffix: nil, scopes: true, strict_mode: false, **_options
  )
    enum_klass_name = name.to_s.camelize
    enum_values = ActiveSupport::HashWithIndifferentAccess.new
    # we don't need to use the actual enum value
    typed_enum_values = gen_typed_enum_values(values)

    typed_enum_values.each_pair.each do |label, value|
      enum_values[label] = value
    end
    # create dynamic T::Enum definition
    if const_defined?(enum_klass_name)
      # append Enum to avoid conflict
      enum_klass_name = "#{enum_klass_name}Enum"
      if const_defined?(enum_klass_name)
        raise ConflictTypedEnumNameError, "Unable to define enum class #{enum_klass_name} because
          it's already defined".squish!
      end
    end
    enum_klass = Class.new(T::Enum) do
      enums do
        typed_enum_values.each do |enum_key_name, typed_enum_value|
          const_set(typed_enum_value, new(enum_key_name))
        end
      end
    end
    const_set(enum_klass_name, enum_klass)

    # create t_enum getter to get T::Enum value
    # assuming there shouldn't be any conflict
    typed_enum_getter_name = "typed_#{name}"
    detect_enum_conflict!(name, typed_enum_getter_name)
    define_method(typed_enum_getter_name) do
      T.unsafe(enum_klass).try_deserialize(send(name))
    end

    # override the setter to accept T::Enum values
    enum_setter_name = "#{name}="
    typed_enum_setter_name = "typed_#{name}="
    detect_enum_conflict!(name, typed_enum_setter_name)
    define_method(typed_enum_setter_name) do |value|
      send(enum_setter_name, value&.serialize)
    end

    # add to the config for RBI generation only if it works
    typed_enum_reflections[name.to_s] = SorbetRails::TypedEnumConfig.new(
      strict_mode: strict_mode || false,
      class_name: enum_klass_name
    )
  end

  sig do
    params(enum_values: T.any(
      T::Array[T.untyped],
      T::Hash[T.untyped, T.untyped],
      ActiveSupport::HashWithIndifferentAccess
    )).returns(T::Hash[String, String])
  end
  def gen_typed_enum_values(enum_values)
    pairs = enum_values.respond_to?(:each_pair) ? enum_values.each_pair : enum_values.each_with_index

    pairs.map do |label, _val|
      [label.to_s, label.to_s.gsub(/[^0-9a-z_]/i, '').camelize]
    end.to_h
  end

  class MultipleEnumsDefinedError < StandardError; end
  class ConflictTypedEnumNameError < StandardError; end
end
