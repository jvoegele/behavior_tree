module BehaviorTree
  class BranchNode
    def initialize(*children)
      @children = children.flatten
    end

    attr_reader :children

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
end
