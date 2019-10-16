class ConsoleInterface
  attr_reader :output
  
  def initialize(output: nil)
    @output = output
  end

  def print_result(result)
    self.output.puts result
  end

  def ask_question
    self.output.puts "Would you like to continue? [yN]"
  end
end