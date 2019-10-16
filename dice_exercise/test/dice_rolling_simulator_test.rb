require 'minitest/autorun'
require 'shoulda'

require 'mocha'
require 'mocha/minitest'

require './lib/dice_rolling_simulator.rb'


class DiceRollingSimulatorTest < Minitest::Test
  context '#run' do
    should 'ask the user if they want to continue' do
      console_interface = ConsoleInterface.new
      console_interface.expects(:ask_question)
      console_interface.stubs(:answer).returns(false)
      console_interface.stubs(:print_result)
      
      simulator = DiceRollingSimulator.new(console_interface: console_interface)
      simulator.run
    end

    should 'ask the user if they want to continue until they answer no' do
      console_interface = ConsoleInterface.new
      console_interface.expects(:ask_question).times(3)
      console_interface.stubs(:answer).returns(true).returns(true).then.returns(false)
      console_interface.stubs(:print_result)
      
      simulator = DiceRollingSimulator.new(console_interface: console_interface)
      simulator.run
    end

    should 'print the dice results' do
      dice = Dice.new
      dice.stubs(:roll).returns(5)

      console_interface = ConsoleInterface.new
      console_interface.expects(:print_result).with("You rolled a 5.")
      console_interface.stubs(:ask_question)
      console_interface.stubs(:answer).returns(false)

      simulator = DiceRollingSimulator.new(dice: dice, console_interface: console_interface)
      simulator.run
    end
  end
end