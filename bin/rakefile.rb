require "rake/testtask"

task "test"

Rake::TestTask.new do |task|
  task.libs << "lib"
  task.libs << "test"
  task.pattern = "test/*_test.rb"
end