require "behavior_tree/version"

module BehaviorTree
  class Action
    def initialize(&block)
      @action = block
    end
    def behave
      @action.call
      true
    end
  end

  class Condition
    def initialize(&block)
      @condition = block
    end
    def behave
      @condition.call
    end
  end

  class BranchNode
    def initialize(*children)
      @children = children
    end

    def <<(node)
      @children << node
    end

    def behave
      if $_behavior_tree_continuation
        return $_behavior_tree_continuation.call
      else
        @children.each do |child|
          child_result = child.behave
          if child_result.is_a?(Continuation)
            return child_result
          else
            case handle_child_result(child_result)
            when :return_true
              return true
            when :return_false
              return false
            end
          end
        end
        return branch_result
      end
    end
  end

  class Sequence < BranchNode
    def handle_child_result(child_result)
      unless child_result
        :return_false
      end
    end

    def branch_result
      true
    end
  end

  class Selector < BranchNode
    def handle_child_result(child_result)
      if child_result
        :return_true
      end
    end

    def branch_result
      false
    end
  end

  class Decorator
    def initialize(node, &block)
      @node = node
      @block = block
    end

    def behave
      @block.call(@node)
    end
  end

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

  def action(&block)
    Action.new(&block)
  end
  def condition(&block)
    Condition.new(&block)
  end

  def sequence(*args)
    Sequence.new(*args)
  end
  def selector(*args)
    Selector.new(*args)
  end

  def decorator(node, &block)
    Decorator.new(node, &block)
  end

end
