require_relative 'dice.rb'
require_relative 'console_interface.rb'

class DiceRollingSimulator
  attr_reader :dice, :console_interface

  def initialize(dice: Dice.new, console_interface: ConsoleInterface.new)
    @dice = dice
    @console_interface = console_interface
  end

  def run
    continue = true
    while continue do
      console_interface.print_result("You rolled a #{dice.roll}.")
      console_interface.ask_question
      continue = console_interface.answer
    end
  end
end