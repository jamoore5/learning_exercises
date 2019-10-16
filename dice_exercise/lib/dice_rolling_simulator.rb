class DiceRollingSimulator
  attr :console_interface

  def initialize(console_interface: nil)
    @console_interface = console_interface
  end

  def run
    continue = true
    while continue do
      console_interface.ask_question
      continue = console_interface.answer
    end
  end
end