require "test_helper"

class EmbeddedTest < BaseTest
  def test_embedded_sequence
    parent = ParentSequencedModel.create
    child = parent.child_sequenced_models.create
    
    assert_equal parent.auto_increment, 1
    assert_equal child.child_auto_increment, 1
  end
end
