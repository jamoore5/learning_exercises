require 'minitest/autorun'
require 'shoulda'
require 'mocha'
require 'mocha/minitest'

require_relative '../lib/guessing_game.rb'

class GuessingGameTest < Minitest::Test

  context 'defaults' do
    should 'default min to 1' do
      GuessingGame.reset_defaults
      assert_equal 1, GuessingGame.min
    end

    should 'default max to 10' do
      GuessingGame.reset_defaults
      assert_equal 10, GuessingGame.max
    end

    should 'default max_tries to 3' do
      GuessingGame.reset_defaults
      assert_equal 3, GuessingGame.max_tries
    end

    should 'default console_interface to a ConsoleInterface instance' do
      GuessingGame.reset_defaults
      assert GuessingGame.console_interface.is_a?(ConsoleInterface)
    end
  end

  context '#play' do
    should 'play a winning game in one try' do
      GuessingGame.min = 1
      GuessingGame.max = 100
      GuessingGame.max_tries = 3

      console_interface = ConsoleInterface.new
      console_interface.expects(:print_msg).with("I am thinking of a number between 1 and 100.")
      console_interface.expects(:print_msg).with("Correct, and you guessed in only 1 try.")
      GuessingGame.console_interface = console_interface

      game = GuessingGame.new(4)
      GuessingGame.console_interface.stubs(:make_guess).returns(4)

      GuessingGame.play(game)
    end

    should 'play a winning game' do
      GuessingGame.min = 1
      GuessingGame.max = 100
      GuessingGame.max_tries = 3

      console_interface = ConsoleInterface.new
      console_interface.expects(:print_msg).with("I am thinking of a number between 1 and 100.")
      console_interface.expects(:print_msg).with("Larger")
      console_interface.expects(:print_msg).with("Smaller")
      console_interface.expects(:print_msg).with("Correct, and you guessed in only 3 tries.")
      GuessingGame.console_interface = console_interface

      game = GuessingGame.new(4)
      GuessingGame.console_interface.stubs(:make_guess).returns(5,3,4)

      GuessingGame.play(game)
    end

    should 'play a losing game' do
      GuessingGame.min = 1
      GuessingGame.max = 10
      GuessingGame.max_tries = 4

      console_interface = ConsoleInterface.new
      console_interface.expects(:print_msg).with("I am thinking of a number between 1 and 10.")
      console_interface.expects(:print_msg).with("Larger").times(4)
      console_interface.expects(:print_msg).with("Sorry you are out of ties, I was thinking of 10.")
      GuessingGame.console_interface = console_interface

      game = GuessingGame.new(10)
      GuessingGame.console_interface.stubs(:make_guess).returns(5).times(4)

      GuessingGame.play(game)
    end
  end

  context '#run' do
    should 'play a game' do
      GuessingGame.console_interface = ConsoleInterface.new
      GuessingGame.console_interface.expects(:play_agin).returns(false)
      GuessingGame.expects(:play)

      GuessingGame.run
    end

    should 'play 5 games if the user plays again 4 times then stops' do
      GuessingGame.console_interface = ConsoleInterface.new
      GuessingGame.console_interface.expects(:play_agin).returns(true, true, true, true, false).times(5)
      GuessingGame.expects(:play).times(5)

      GuessingGame.run
    end
  end
end
