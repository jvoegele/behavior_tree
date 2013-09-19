behavior_tree
=============

Implementation of the Behavior Tree concept in Ruby

Some background information about behavior trees can be found at:

* http://aigamedev.com/open/article/bt-overview/
* http://aigamedev.com/open/article/behavior-trees-part1/
* http://aigamedev.com/open/article/behavior-trees-part2/
* http://aigamedev.com/open/article/behavior-trees-part3/

## Usage

Here is an example usage of BehaviorTree that decides whether now is a good
time to drink beer. This behavior tree will decide to drink beer if it is
a weekend and after 4:30, or if it is a bowling night (Thursday after 7:00).

```ruby
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
    puts 'Drinking beer!'
  end

  def no_drink!
    puts 'Sigh, no beer for me :-('
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

