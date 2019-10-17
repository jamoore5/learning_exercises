require 'active_support'
require 'active_support/inflector'

require_relative 'console_interface.rb'

class GuessingGame
  cattr_accessor :min, :max, :max_tries, :console_interface
  attr :number, :tries, :guess

  MIN = 1
  MAX = 10
  MAX_TRIES = 3
  CONSOLE_INTERFACE = ConsoleInterface.new

  @@min = MIN
  @@max = MAX
  @@max_tries = MAX_TRIES
  @@console_interface = CONSOLE_INTERFACE

  def self.run
    play_agin = true

    while play_agin do
      GuessingGame.play
      play_agin = console_interface.play_agin
    end
  end

  def self.play(game = GuessingGame.new)
    game.play
  end

  def play
    print_introduction

    while !game_over do
      make_guess
    end

    print_results(tries, guess, number)
  end

  def self.reset_defaults
    @@min = MIN
    @@max = MAX
    @@max_tries = MAX_TRIES
    @@console_interface = CONSOLE_INTERFACE
  end

  private

  def initialize(number = random_number)
    @number = number
    @tries = 0
    @guess = nil
  end

  def random_number
    @number = rand(max) + min
  end

  def game_over
    (guess == number || tries >= max_tries)
  end

  def make_guess
    @tries = tries + 1
    @guess = console_interface.make_guess
    give_clue(number, guess)
  end

  def print_introduction
    console_interface.print_msg "I am thinking of a number between #{min} and #{max}."
  end

  def give_clue(number, guess)
    if guess < number
      console_interface.print_msg "Larger"
    elsif guess > number
      console_interface.print_msg 'Smaller'
    end
  end

  def print_results(tries, guess, number)
    if guess == number
      console_interface.print_msg "Correct, and you guessed in only #{tries} #{'try'.pluralize(tries)}."
    else
      console_interface.print_msg "Sorry you are out of ties, I was thinking of #{number}."
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  GuessingGame.run
end