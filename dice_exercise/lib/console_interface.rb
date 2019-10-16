class ConsoleInterface
  attr_reader :output
  
  def initialize(output: nil)
    @output = output
  end

  def print_result(result)
    self.output.puts result
  end
end