require 'test_helper'
require 'mad_libs'

class MabLibsTest < Minitest::Test
  context '#initialize' do
    should 'set the story formatted for printing with the user input' do
      madlibs = MadLibs.new('I am a/an <noun>.')
      
      assert_equal 'I am a/an %s.', madlibs.story
    end

    should 'set array of missing words as MadLibsWord' do
      madlibs = MadLibs.new('I am a/an <noun>.')

      assert_equal 1, madlibs.words.size
      word = madlibs.words.first
      assert word.is_a?(MadLibsWord)
      assert_equal 'noun', word.speech_type
      assert_nil word.input_word
    end
  end

  context '#ask_for_missing_words' do
    should 'print the speech_type to stdout' do
      madlibs = MadLibs.new('I am a/an <noun>.')

      $stdout.expects(:print).with(includes('noun'))
      $stdin.stubs(:gets)

      madlibs.ask_for_missing_words
    end

    should 'prompt the user for the missing word' do
      madlibs = MadLibs.new('I am a/an <noun>.')

      $stdout.stubs(:print)
      $stdin.expects(:gets).returns('dog')

      madlibs.ask_for_missing_words

      word = madlibs.words.first
      assert_equal 'noun', word.speech_type
      assert_equal 'dog', word.input_word
    end
  end

  context '#print_story' do
    should 'print the story with the user inputted words' do
      madlibs = MadLibs.new('I am a/an <noun>.')

      word = madlibs.words.first
      word.input_word = 'dog'

      assert_equal 'I am a/an dog.', madlibs.final_story
    end
  end

  context '#play_story' do
    should 'play a basic game and output the result' do
      story = 'I am a/an <adjective> <noun>.'

      $stdout.expects(:print).with(includes('adjective'))
      $stdout.expects(:print).with(includes('noun'))
      $stdin.expects(:gets).twice.returns('friendly', 'dog')

      $stdout.expects(:puts).with('I am a/an friendly dog.')

      MadLibs.play_story(story)
    end
  end
end