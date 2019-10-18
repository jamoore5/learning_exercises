require 'test_helper'
require 'mad_libs_stories'

class MadLibsStoriesTest < Minitest::Test
  context '#fetch_files' do
    should 'include goofy_mad_libs.txt' do
      files = MadLibsStories.fetch_story_files
      assert !files.select{ |file| file.include?('goofy_mad_libs.txt') }.empty?
    end

    should 'not include _test.txt' do
      files = MadLibsStories.fetch_story_files
      assert files.select{ |file| file.include?('_test.txt') }.empty?
    end
  end

  context '#read' do
    should 'read the contents of _test.txt' do
      story = MadLibsStories.read(MadLibsStories::DIRECTORY+'_test.txt')
      assert_equal 'I am a/an <adjective> <noun>.', story
    end
  end
end