# This is an autogenerated file for dynamic methods in Potion
# Please rerun bundle exec rake rails_rbi:models[Potion] to regenerate.

# typed: strong
module Potion::ActiveRelation_WhereNot
  sig { params(opts: T.untyped, rest: T.untyped).returns(T.self_type) }
  def not(opts, *rest); end
end

module Potion::GeneratedAssociationMethods
  sig { returns(T.nilable(::Wizard)) }
  def wizard; end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Wizard).void)).returns(::Wizard) }
  def build_wizard(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Wizard).void)).returns(::Wizard) }
  def create_wizard(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.params(object: ::Wizard).void)).returns(::Wizard) }
  def create_wizard!(*args, &block); end

  sig { params(value: T.nilable(::Wizard)).void }
  def wizard=(value); end

  sig { returns(T.nilable(::Wizard)) }
  def reload_wizard; end
end

module Potion::CustomFinderMethods
  sig { params(limit: Integer).returns(T::Array[Potion]) }
  def first_n(limit); end

  sig { params(limit: Integer).returns(T::Array[Potion]) }
  def last_n(limit); end

  sig { params(args: T::Array[T.any(Integer, String)]).returns(T::Array[Potion]) }
  def find_n(*args); end

  sig { params(id: T.nilable(Integer)).returns(T.nilable(Potion)) }
  def find_by_id(id); end

  sig { params(id: Integer).returns(Potion) }
  def find_by_id!(id); end
end

class Potion < ApplicationRecord
  include Potion::GeneratedAssociationMethods
  extend Potion::CustomFinderMethods
  extend Potion::QueryMethodsReturningRelation
  RelationType = T.type_alias { T.any(Potion::ActiveRecord_Relation, Potion::ActiveRecord_Associations_CollectionProxy, Potion::ActiveRecord_AssociationRelation) }
end

module Potion::QueryMethodsReturningRelation
  sig { returns(Potion::ActiveRecord_Relation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Potion::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_Relation) }
  def except(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Potion::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Potion::ActiveRecord_Relation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

module Potion::QueryMethodsReturningAssociationRelation
  sig { returns(Potion::ActiveRecord_AssociationRelation) }
  def all; end

  sig { params(block: T.nilable(T.proc.void)).returns(Potion::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def select(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def order(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def reorder(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def group(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def limit(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def offset(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def joins(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def left_joins(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def left_outer_joins(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def where(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def rewhere(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def preload(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def eager_load(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def includes(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def from(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def lock(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def readonly(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def or(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def having(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def create_with(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def distinct(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def references(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def none(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def unscope(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def merge(*args); end

  sig { params(args: T.untyped).returns(Potion::ActiveRecord_AssociationRelation) }
  def except(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Potion::ActiveRecord_AssociationRelation) }
  def extending(*args, &block); end

  sig do
    params(
      of: T.nilable(Integer),
      start: T.nilable(Integer),
      finish: T.nilable(Integer),
      load: T.nilable(T::Boolean),
      error_on_ignore: T.nilable(T::Boolean),
      block: T.nilable(T.proc.params(e: Potion::ActiveRecord_AssociationRelation).void)
    ).returns(ActiveRecord::Batches::BatchEnumerator)
  end
  def in_batches(of: 1000, start: nil, finish: nil, load: false, error_on_ignore: nil, &block); end
end

class Potion::ActiveRecord_Relation < ActiveRecord::Relation
  include Potion::ActiveRelation_WhereNot
  include Potion::CustomFinderMethods
  include Potion::QueryMethodsReturningRelation
  Elem = type_member(fixed: Potion)
end

class Potion::ActiveRecord_AssociationRelation < ActiveRecord::AssociationRelation
  include Potion::ActiveRelation_WhereNot
  include Potion::CustomFinderMethods
  include Potion::QueryMethodsReturningAssociationRelation
  Elem = type_member(fixed: Potion)
end

class Potion::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Potion::CustomFinderMethods
  include Potion::QueryMethodsReturningAssociationRelation
  Elem = type_member(fixed: Potion)

  sig { params(records: T.any(Potion, T::Array[Potion])).returns(T.self_type) }
  def <<(*records); end

  sig { params(records: T.any(Potion, T::Array[Potion])).returns(T.self_type) }
  def append(*records); end

  sig { params(records: T.any(Potion, T::Array[Potion])).returns(T.self_type) }
  def push(*records); end

  sig { params(records: T.any(Potion, T::Array[Potion])).returns(T.self_type) }
  def concat(*records); end
end
