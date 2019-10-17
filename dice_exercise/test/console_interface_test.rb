require 'test_helper'
require 'console_interface'

class ConsoleInterfaceTest < Minitest::Test
  context '#print_result' do
    should 'call puts on the output with results' do
      result = "The result is 5"
      $stdout.expects(:puts).with(result)

      console_interface = ConsoleInterface.new
      console_interface.print_result(result)
    end
  end

  context '#ask_question' do
    should 'ask user if the to continue' do
      $stdout.expects(:puts).with(ConsoleInterface::QUESTION)

      console_interface = ConsoleInterface.new
      console_interface.ask_question
    end
  end

  context '#answer' do
    should 'return true if the user inputs y' do
      $stdin.expects(:gets).returns("y")

      console_interface = ConsoleInterface.new
      assert console_interface.answer
    end

    should 'return true if the user inputs Y\n' do
      $stdin.expects(:gets).returns("Y\n")

      console_interface = ConsoleInterface.new
      assert console_interface.answer
    end

    should 'return false if the user inputs N' do
      $stdin.expects(:gets).returns("n")

      console_interface = ConsoleInterface.new
      assert ! console_interface.answer
    end
  end

end