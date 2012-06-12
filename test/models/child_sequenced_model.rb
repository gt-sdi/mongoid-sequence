class ChildSequencedModel
  include Mongoid::Document
  include Mongoid::Sequence

  field :child_auto_increment, :type => Integer
  sequence :child_auto_increment
  
  embedded_in :child_sequenced_models, :inverse_of => :child_sequenced_models
end
