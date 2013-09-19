require 'spec_helper'

class DslUser
  include BehaviorTree
  def make_action(*args)
    action(*args) { puts 'hello' }
  end
  def make_condition(*args)
    condition(*args) { puts 'hello' }
  end
  def make_sequence(*args)
    sequence(*args)
  end
  def make_selector(*args)
    selector(*args)
  end
end

module BehaviorTree
  describe "DSL" do
    describe "action" do
      it "creates a BehaviorTree::Action" do
        node = DslUser.new.make_action
        node.should be_kind_of(Action)
      end

      it "accepts an optional label" do
        node = DslUser.new.make_action('a label')
        node.label.should == 'a label'
      end
    end

    describe "condition" do
      it "creates a BehaviorTree::Condition" do
        node = DslUser.new.make_condition
        node.should be_kind_of(Condition)
      end

      it "accepts an optional label" do
        node = DslUser.new.make_condition('a label')
        node.label.should == 'a label'
      end
    end

    describe "sequence" do
      it "creates a BehaviorTree::Sequence" do
        node = DslUser.new.make_sequence(Condition.new {true}, Action.new {puts})
        node.should be_kind_of(Sequence)
      end
    end
    describe "selector" do
      it "creates a BehaviorTree::Selector" do
        node = DslUser.new.make_selector(Condition.new {true}, Action.new {puts})
        node.should be_kind_of(Selector)
      end
    end
  end
end
