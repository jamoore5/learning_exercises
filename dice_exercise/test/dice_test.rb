require 'test_helper'
require 'dice'

class DiceTest < Minitest::Test
  context '#roll' do
    should 'return an integer' do
      dice = Dice.new
      result = dice.roll
      assert result.is_a?(Integer)
    end

    should 'return a result between 1 and 6' do
      dice = Dice.new
      result = dice.roll
      assert [1,2,3,4,5,6].include?(result)
    end
  end
end