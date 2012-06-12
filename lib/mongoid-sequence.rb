require "mongoid-sequence/version"
require "active_support/concern"
require "set"

module Mongoid
  module Sequence
    extend ActiveSupport::Concern

    included do
      set_callback :validate, :before, :set_sequence, :unless => :persisted?
    end

    module ClassMethods
      attr_accessor :sequence_fields
      attr_accessor :klazzes

      def sequence(field)
        self.klazzes ||= Set.new
        self.klazzes << self
        self.sequence_fields ||= []
        self.sequence_fields << field
      end

      def use_superclass_sequence
        self.klazzes ||= self.superclass.klazzes = Set.new
        self.klazzes << self.superclass
      end

    end

    def set_sequence
      sequences = get_sequence_collection
      self.class.klazzes.each do |klazz|
        klazz.sequence_fields.each do |field|
          next_sequence = sequences.find_and_modify(:query  => {"_id" => "#{klazz.name.underscore}_#{field}"},
                                                    :update => {"$inc" => {"seq" => 1}},
                                                    :new    => true,
                                                    :upsert => true)

          self[field] = next_sequence["seq"]
        end if klazz.sequence_fields
      end
    end
    
    def get_sequence_collection
      if self.embedded?
        sequences = self._parent.db.collection("__sequences")
      else
        sequences = self.db.collection("__sequences")
      end
    end
  end
end
