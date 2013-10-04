module BehaviorTree
  class LeafNode < NodeBase
    include Util
    def initialize(label="")
      @label = label
    end

    attr_accessor :label

    def to_graphviz(graph=nil)
      graph ||= create_graph
      graph.add_node(self.object_id.to_s, graphviz_node_attrs)
    end
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

    def to_s
      "act(#{label}) #{to_source(@action)} "
    end

    private

    def graphviz_node_attrs
      {label: self.to_s, shape: 'octagon', fillcolor: 'red'}
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

    def to_s
      "cond(#{label}) #{to_source(@condition)}"
    end

    private

    def graphviz_node_attrs
      {label: self.to_s, shape: 'rarrow', fillcolor: 'yellow'}
    end
  end
end
