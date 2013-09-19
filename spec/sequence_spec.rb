require 'spec_helper'

module BehaviorTree
  describe Sequence do
    describe "#children" do
      it "has a list of children" do
        children = [Condition.new { true }, Condition.new { false }]
        seq = Sequence.new(*children)
        seq.children.should == children
      end
    end

    describe "#behave" do
      it "returns true if all nodes evaluated truthfully" do
        seq = Sequence.new(Condition.new {true}, Condition.new{true})
        seq.behave.should be_true
      end

      it "returns false if any node evaluated untruthfully" do
        seq = Sequence.new(Condition.new {false}, Condition.new {true})
        seq.behave.should be_false
      end

      it "evaluates all children until one returns false" do
        last_evaluated = nil
        children = [
          Condition.new { true && last_evaluated = 1 },
          Condition.new { (2 > 1) && last_evaluated = 2 },
          Condition.new { (1 > 2) && last_evaluated = 3 }
        ]
        seq = Sequence.new(children)
        result = seq.behave
        result.should be_false
        last_evaluated.should == 2
      end
    end
  end
end
