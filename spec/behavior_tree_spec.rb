require 'spec_helper'

module BehaviorTree
  describe BehaviorTree do

    it 'should have a version number' do
      BehaviorTree::VERSION.should_not be_nil
    end

    describe LeafNode do
      describe "#initialize" do
        it "takes an optional string label" do
          node = LeafNode.new("arbitrary text")
          node.label.should == "arbitrary text"
        end
      end
    end
  end
end
