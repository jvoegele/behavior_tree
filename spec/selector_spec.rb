require 'spec_helper'

module BehaviorTree
  describe Selector do
    describe "#children" do
      it "has a list of children" do
        children = [Condition.new { true }, Condition.new { false }]
        sel = Selector.new(*children)
        sel.children.should == children
      end
    end

    describe "#behave" do
      it "returns true if a node evaluated truthfully" do
        sel = Selector.new(Condition.new {true}, Condition.new{true})
        sel.behave.should be_true
      end

      it "returns false if all nodes evaluated untruthfully" do
        sel = Selector.new(Condition.new {false}, Condition.new {false})
        sel.behave.should be_false
      end

      it "evaluates all children until one returns true" do
        last_evaluated = nil
        children = [
          Condition.new { false && last_evaluated = 1 },
          Condition.new { (2 > 1) && last_evaluated = 2 },
          Condition.new { (1 > 2) && last_evaluated = 3 }
        ]
        sel = Selector.new(children)
        result = sel.behave
        result.should be_true
        last_evaluated.should == 2
      end
    end
  end
end
