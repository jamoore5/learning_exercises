require_relative 'mad_libs_stories'

require 'pry'
require 'pry-byebug'

class MadLibs
  attr_accessor :story, :words

  def self.play
    binding.pry
    stories_filesnames = MadLibsStories.fetch_story_files

    continue = true
    while (continue && !stories_filesnames.empty?)
      story_filename = stories_filesnames.pop
      story = MadLibsStories.read(story_filename)
      play_story(story)

      $stdout.print "Do you want to do another story? [yN]"
      continue = $stdin.gets.chomp.downcase == 'y'
    end

    if stories_filesnames.empty?
      $stdout.puts "Sorry, we have ran out of stories."
    end
  end

  def self.play_story(story)
    madlibs = MadLibs.new(story)
    madlibs.ask_for_missing_words
    $stdout.puts madlibs.final_story
  end

  def initialize(story)
    process_story(story)
  end

  def ask_for_missing_words
    words.each do |word|
      $stdout.print "#{word.speech_type}: "
      word.input_word = $stdin.gets.chomp
    end
  end

  def final_story
    story % words.map{ |word| word.input_word }
  end

  private

  MISSING_WORD_REGEX = /(<[^>]*>)/

  def process_story(story)
    @words = process_words(story)
    @story = story.gsub(MISSING_WORD_REGEX, '%s')
  end

  def process_words(story)
    story.scan(MISSING_WORD_REGEX).map{|match| process_word(match) }
  end

  def process_word(match)
    speech_type = match.first[1..-2]
    MadLibsWord.new(speech_type)
  end
end

class MadLibsWord
  attr_accessor :speech_type, :input_word

  def initialize(speech_type)
    @speech_type = speech_type
  end
end

if __FILE__ == $PROGRAM_NAME
  MadLibs.play
end