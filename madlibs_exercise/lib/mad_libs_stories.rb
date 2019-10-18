class MadLibsStories

  DIRECTORY = './data/stories/'

  def self.fetch_story_files
    Dir[DIRECTORY+'*.txt'].reject{ |file| file.include?('_test.txt') }.shuffle
  end

  def self.read(file)
    File.read(file)
  end
end