module BehaviorTree
  module DSL
    def action(label='', &block)
      Action.new(label, &block)
    end
    alias_method :act, :action

    def condition(label='', &block)
      Condition.new(label, &block)
    end
    alias_method :cond, :condition

    def sequence(*args)
      Sequence.new(*args)
    end
    alias_method :seq, :sequence

    def selector(*args)
      Selector.new(*args)
    end
    alias_method :sel, :selector
  end

  include DSL
end
