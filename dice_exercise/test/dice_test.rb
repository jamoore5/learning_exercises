require 'minitest/autorun'
require 'shoulda'

require './lib/dice.rb'

class DiceTest < Minitest::Test
	context '#roll' do
		should 'return an integer' do
			dice = Dice.new
			result = dice.roll
			# assert dice.is_a?(Integer)
		end
	end
end