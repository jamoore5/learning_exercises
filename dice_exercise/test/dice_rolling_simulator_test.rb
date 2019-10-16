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
      
      simulator = DiceRollingSimulator.new(console_interface: console_interface)
      simulator.run
    end
  end
end