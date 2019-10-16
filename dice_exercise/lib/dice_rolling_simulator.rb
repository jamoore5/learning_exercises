class DiceRollingSimulator
  attr :console_interface

  def initialize(console_interface: console_interface)
    @console_interface = console_interface
  end

  def run
    console_interface.ask_question
  end
end