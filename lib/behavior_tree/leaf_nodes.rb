module BehaviorTree
  class LeafNode
    def initialize(label="")
      @label = label
    end

    attr_accessor :label
  end


  # Leaf node that executes a given action block when evaluated.
  class Action < LeafNode
    def initialize(label="", &block)
      super(label)
      @action = block
    end

    def behave
      @action.call
      true
    end
  end

  # Leaf node that executes a given condition block when evaluated,
  # returning the result of the block.
  class Condition < LeafNode
    def initialize(label="", &block)
      super(label)
      @condition = block
    end
    def behave
      @condition.call
    end
  end
end
