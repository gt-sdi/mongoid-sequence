class SubClassSelfSequencedModel < FirstSequencedModel

  field :sequence, :type => Integer
  sequence :sequence

end
