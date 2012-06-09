class SubClassMultiSequencedModel < FirstSequencedModel

  field :sequence, :type => Integer
  sequence :sequence
  
  use_superclass_sequence

end
