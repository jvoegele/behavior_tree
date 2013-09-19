module BehaviorTree
  class PryDecorator
    def initialize(node)
      @node = node
    end

    def behave
      binding.pry
      @node.behave
    end
  end

  class ContinuationDecorator
    def initialize(node, &block)
      @node = node
      @block = block
    end

    def behave
      callcc { |cc|
        $_behavior_tree_continuation = cc
      }
      unless @block.call
        node_result = @node.behave
        if node_result
          return $_behavior_tree_continuation
        else
          return false
        end
      end
      $_behavior_tree_continuation = nil
      true
    end
  end

  class LoopDecorator
    def initialize(node, &block)
      @node = node
      @block = block
    end

    def behave
      while @block.call
        @node.behave
      end
    end
  end
end
