require "behavior_tree/version"
require 'sourcify'
require 'graphviz'
require 'continuation'

module BehaviorTree
  class NodeBase
    attr_accessor :label

    private

    # Subclasses should override to return a Hash that will be passed to the
    # GraphViz add_node method.
    def graphviz_node_attrs
      {}
    end
  end

  module Util
    def create_graph
      GraphViz.new(:G, :type => :digraph)
    end

    def to_source(block)
      if block
        begin
          src = block.to_source
          src[/\{(.*)}/]
        rescue Exception
          ""
        end
      else
        ""
      end
    end
  end
end

require 'behavior_tree/leaf_nodes'
require 'behavior_tree/branch_nodes'
require 'behavior_tree/decorators'
require 'behavior_tree/dsl'
