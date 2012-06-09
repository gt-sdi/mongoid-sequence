require "test_helper"

class SubClassTest < BaseTest
  def test_subclass_parent_sequence
    parent = FirstSequencedModel.create
    child = SubClassSuperSequencedModel.create
  
    assert_equal parent.auto_increment + 1, child.auto_increment
    
    parent2 = FirstSequencedModel.create
    child2 = SubClassSuperSequencedModel.create

    assert_equal parent2.auto_increment + 1, child2.auto_increment
  end
  
  def test_subclass_self_sequence
    parent = FirstSequencedModel.create
    child = SubClassSelfSequencedModel.create
    
    assert_equal parent.auto_increment, 1
    assert_equal child.auto_increment, nil
    assert_equal child.sequence, 1
    
    parent2 = FirstSequencedModel.create
    child2 = SubClassSelfSequencedModel.create
    
    assert_equal parent2.auto_increment, 2
    assert_equal child2.auto_increment, nil
    assert_equal child2.sequence, 2
  end
  
  def test_subclass_multi_sequence
    parent = FirstSequencedModel.create
    child = SubClassMultiSequencedModel.create
    
    assert_equal parent.auto_increment, 1
    assert_equal child.auto_increment, 2
    assert_equal child.sequence, 1

    parent2 = FirstSequencedModel.create
    child2 = SubClassMultiSequencedModel.create
    
    assert_equal parent2.auto_increment, 3
    assert_equal child2.auto_increment, 4
    assert_equal child2.sequence, 2
  end
end