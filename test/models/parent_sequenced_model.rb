class ParentSequencedModel
  include Mongoid::Document
  include Mongoid::Sequence

  field :auto_increment, :type => Integer
  sequence :auto_increment
  
  embeds_many :child_sequenced_models
end
