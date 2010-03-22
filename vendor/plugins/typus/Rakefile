require 'rubygems'
require 'rake/testtask'
require 'rake/rdoctask'

require File.expand_path('../lib/typus/version', __FILE__)

$LOAD_PATH.unshift 'lib'
require 'typus'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the typus plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate specdoc-style documentation from tests'
task :specs do

  puts 'Started'
  timer, count = Time.now, 0

  File.open('SPECDOC', 'w') do |file|
    Dir.glob('test/**/*_test.rb').each do |test|
      test =~ /.*\/([^\/].*)_test.rb$/
      file.puts "#{$1.gsub('_', ' ').capitalize} should:" if $1
      File.read(test).map { |line| /test_(.*)$/.match line }.compact.each do |spec|
        file.puts "- #{spec[1].gsub('_', ' ')}"
        sleep 0.001; print '.'; $stdout.flush; count += 1
      end
      file.puts
    end
  end

  puts "\nFinished in #{Time.now - timer} seconds.\n"
  puts "#{count} specifications documented"

end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "typus"
    gemspec.summary = "Effortless backend interface for Ruby on Rails applications. (Admin scaffold generator.)"
    gemspec.description = "Effortless backend interface for Ruby on Rails applications. (Admin scaffold generator.)"
    gemspec.email = "francesc@intraducibles.com"
    gemspec.homepage = "http://intraducibles.com/projects/typus"
    gemspec.authors = ["Francesc Esplugas"]
    gemspec.version = Typus::VERSION::STRING
  end
rescue LoadError
  puts "Jeweler not available."
  puts "Install it with: gem install jeweler -s http://gemcutter.org"
end

desc "Generate package."
task :package => [ :gemspec, :build ]

desc "Push a new version to Gemcutter"
task :publish => [ :package ] do
  version = Typus::VERSION::STRING
  system "git tag v#{version}"
  system "git push origin v#{version}"
  system "gem push pkg/typus-#{version}.gem"
  system "git clean -fd"
end
