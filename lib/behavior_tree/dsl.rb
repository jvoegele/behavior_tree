module BehaviorTree
  module DSL
    def action(label='', &block)
      Action.new(label, &block)
    end

    def condition(label='', &block)
      Condition.new(label, &block)
    end

    def sequence(*args)
      Sequence.new(*args)
    end

    def selector(*args)
      Selector.new(*args)
    end
  end

  include DSL
end
