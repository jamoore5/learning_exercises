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
      console_interface.stubs(:answer)
      
      simulator = DiceRollingSimulator.new(console_interface: console_interface)
      simulator.run
    end

    should 'ask the user if they want to continue until they answer n' do
      console_interface = ConsoleInterface.new
      console_interface.expects(:ask_question).times(3)
      console_interface.stubs(:answer).returns(true).returns(true).then.returns(false)
      
      simulator = DiceRollingSimulator.new(console_interface: console_interface)
      simulator.run
    end
  end
end