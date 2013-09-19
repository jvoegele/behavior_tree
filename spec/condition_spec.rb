require 'spec_helper'

module BehaviorTree
  describe Condition do
    describe "#behave" do
      it "executes the block given to its initializer" do
        executed = false
        action = Condition.new { executed = true }
        action.behave
        executed.should be_true
      end

      it "returns the result of calling the block" do
        Condition.new { false }.behave.should be_false
      end

      it "propagates exceptions raised by the block" do
        proc do
          Condition.new { raise "EXCEPTION!" }.behave
        end.should raise_error
      end
    end
  end
end

