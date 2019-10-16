require 'minitest/autorun'
require 'shoulda'
require 'mocha'
require 'mocha/minitest'

require './lib/console_interface.rb'

class ConsoleInterfaceTest < Minitest::Test
  context '#print_result' do
    should 'call puts on the output with results' do
      output = mock('stdout')
      result = "The result is 5"
      output.expects(:puts).with(result)

      console_interface = ConsoleInterface.new(output: output)
      console_interface.print_result(result)
    end
  end

  context '#ask_question' do
    should 'ask user if the to continue' do
      output = mock('stdout')
      question = "Would you like to continue? [yN]"
      output.expects(:puts).with(question)

      console_interface = ConsoleInterface.new(output: output)
      console_interface.ask_question
    end
  end

  context '#answer' do
    should 'return true if the user inputs y' do
      input = mock('stdin')
      input.expects(:gets).returns("y")

      console_interface = ConsoleInterface.new(input: input)
      assert_equal true, console_interface.answer
    end

    should 'return true if the user inputs N\n' do
      input = mock('stdin')
      input.expects(:gets).returns("n\n")

      console_interface = ConsoleInterface.new(input: input)
      assert_equal false, console_interface.answer
    end
  end

end