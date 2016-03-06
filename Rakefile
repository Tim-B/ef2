require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "./examples/basic_list"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :example do

  list = BasicList.new
  list.order

end