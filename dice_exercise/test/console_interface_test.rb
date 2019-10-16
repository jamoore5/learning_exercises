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

end