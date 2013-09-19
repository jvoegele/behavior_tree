require 'behavior_tree'

class ToDrinkOrNotToDrink
  include BehaviorTree

  def initialize
    drink = action { drink! }

    @behavior_tree =
      sel(
        seq(
          cond { weekend? },
          cond { beer_30? },
          act { drink! }),

        seq(
          cond { bowling? },
          act { drink! }),

        act { no_drink! })
  end

  def decide
    @behavior_tree.behave
  end

  def weekend?
    today = Time.now
    today.friday? || today.saturday?
  end

  def beer_30?
    now = Time.now
    now.hour >= 16 && now.min >= 30
  end

  def bowling?
    now = Time.now
    now.thursday? && now.hour >= 19
  end

  def drink!
    puts 'Drinking tasty, frothy beer!'
  end

  def no_drink!
    puts 'Sigh, no beer for me :-('
  end
end

if __FILE__ == $0
  behavior = ToDrinkOrNotToDrink.new
  behavior.decide
end
