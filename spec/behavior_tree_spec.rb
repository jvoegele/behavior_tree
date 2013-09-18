require 'spec_helper'

describe BehaviorTree do
  it 'should have a version number' do
    BehaviorTree::VERSION.should_not be_nil
  end
end
