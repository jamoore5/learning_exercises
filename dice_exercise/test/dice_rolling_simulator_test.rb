require 'test_helper'
require 'dice_rolling_simulator'

class DiceRollingSimulatorTest < Minitest::Test
  context '#run' do
    should 'ask the user if they want to continue' do
      console_interface = mock_console_interface
      console_interface.expects(:ask_question)
      
      simulator = DiceRollingSimulator.new(console_interface: console_interface)
      simulator.run
    end

    should 'ask the user if they want to continue until they answer no' do
      console_interface = mock_console_interface
      console_interface.expects(:ask_question).times(3)
      console_interface.stubs(:answer).returns(true).returns(true).then.returns(false)
      
      simulator = DiceRollingSimulator.new(console_interface: console_interface)
      simulator.run
    end

    should 'print the dice results' do
      dice = Dice.new
      dice.stubs(:roll).returns(5)

      console_interface = mock_console_interface
      console_interface.expects(:print_result).with("You rolled a 5.")

      simulator = DiceRollingSimulator.new(dice: dice, console_interface: console_interface)
      simulator.run
    end

    should 'print the dice results same number of times the simulator continues' do
      dice = Dice.new
      dice.stubs(:roll).returns(5)

      console_interface = mock_console_interface
      console_interface.expects(:print_result).with("You rolled a 5.").times(3)
      console_interface.expects(:ask_question).times(3)
      console_interface.stubs(:answer).returns(true).returns(true).then.returns(false)

      simulator = DiceRollingSimulator.new(dice: dice, console_interface: console_interface)
      simulator.run
    end
  end

  def mock_console_interface
    console_interface = ConsoleInterface.new
    console_interface.stubs(:print_result)
    console_interface.stubs(:ask_question)
    console_interface.stubs(:answer).returns(false)
    console_interface
  end
end