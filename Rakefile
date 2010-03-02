require(File.join(File.dirname(__FILE__), 'config', 'environment'))
require "find"

def execute_test(basedir)
  puts basedir
  contents = Dir.new(basedir).entries
  contents.each { |file|
    if( file =~ /([^\s]+(?=\.(rb))\.\2)/ )
      require basedir + "/" + file
    end
  }
end

def execute_tests(dir)
  Find.find(dir) do |path|
    if FileTest.directory?(path) && path != dir
      execute_test(path)
    else
      next
    end
  end
end

task :behaviors do
  puts "testing behaviors"
  dir = "behaviors"
  execute_tests(dir)
end

task :pages do
  puts "testing pages"
  dir = "pages"
  execute_tests(dir)
end

task :performance do
  puts "testing performance"
  basedir = "performance"
  execute_tests(basedir)  
end

task :test do 
  require(File.join(File.dirname(__FILE__), ENV['test_file']))
end

task :full_suite => [:pages, :behaviors, :performance]

task :default => [:full_suite]