class ConsoleInterface
  attr :input, :output

  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def play_agin
    print_msg "Do you want to play again? [yN]"
    input.gets.chomp.downcase == 'y'
  end

  def print_msg(msg)
    output.puts msg
  end

  def make_guess
    print_msg "What is your guess?"
    input.gets.to_i
  end
end