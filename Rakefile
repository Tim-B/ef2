require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'ef2'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :example do

  list = EF2::Domain::List.new
  list.read_list File.dirname(__FILE__) + '/examples/basic_list.rb'
  list.form

end