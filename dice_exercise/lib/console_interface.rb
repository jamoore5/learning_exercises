class ConsoleInterface
  attr :input, :output
  
  def initialize(input: nil, output: nil)
    @input = input
    @output = output
  end

  def print_result(result)
    self.output.puts result
  end

  def ask_question
    self.output.puts "Would you like to continue? [yN]"
  end

  def answer
    self.input.gets == 'y'
  end
end