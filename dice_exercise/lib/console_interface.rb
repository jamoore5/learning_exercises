class ConsoleInterface
  attr :input, :output

  QUESTION = "Would you like to continue? [yN]"
  
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def print_result(result)
    self.output.puts result
  end

  def ask_question
    self.output.puts QUESTION
  end

  def answer
    self.input.gets.chomp.downcase == 'y'
  end
end