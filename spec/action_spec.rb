require 'spec_helper'

module BehaviorTree
  describe Action do
    describe "#behave" do
      it "executes the block given to its initializer" do
        executed = false
        action = Action.new { executed = true }
        action.behave
        executed.should be_true
      end

      it "returns true if it returns at all" do
        Action.new { false }.behave.should be_true
      end

      it "propagates exceptions raised by the block" do
        proc do
          Action.new { raise "EXCEPTION!" }.behave
        end.should raise_error
      end
    end
  end
end
