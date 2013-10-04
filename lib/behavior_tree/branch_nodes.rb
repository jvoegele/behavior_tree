module BehaviorTree
  class BranchNode < NodeBase
    include Util

    def initialize(*children)
      if children.first.is_a?(String) || children.first.is_a?(Symbol)
        @label = children.shift
      end
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

    def to_graphviz(graph=nil)
      if graph.nil?
        graph_created_here = true
        graph = create_graph
      end
      self_node = graph.add_node(self.object_id.to_s, graphviz_node_attrs)
      @children.each do |child|
        child_node = child.to_graphviz(graph)
        graph.add_edge(self_node, child_node)
      end
      graph_created_here ? self_node.root_graph : self_node
    end
  end

  # A Sequence is a branch node that evaluates its children in order until one
  # of them returns false. If all children evaluate to true, then the sequence
  # as a whole evaluates to true. If any child evaluates to false, then
  # evaluation of children is halted and the sequence as a whole evaluates to
  # false.
  class Sequence < BranchNode
    def handle_child_result(child_result)
      unless child_result
        :return_false
      end
    end

    def branch_result
      true
    end

    def to_s
      "sequence(#{label})"
    end

    private

    def graphviz_node_attrs
      {label: self.to_s, shape: 'parallelogram'}
    end

    def graphviz_edge_attrs
      {}
    end
  end

  # A Selector is a branch node that evaluates its children in order until one
  # of them returns true. If all children evaluate to false, then the selector
  # as a whole evaluates to false. If any child evaluates to true, then
  # evaluation of children is halted and the selector as a whole evaluates to
  # true.
  class Selector < BranchNode
    def handle_child_result(child_result)
      if child_result
        :return_true
      end
    end

    def branch_result
      false
    end

    def to_s
      "selector(#{label})"
    end

    private

    def graphviz_node_attrs
      {label: self.to_s, style: 'dashed'}
    end

    def graphviz_edge_attrs
      {}
    end
  end
end
