require "bundler/gem_tasks"
require "rake/testtask"

gemspec_file = Dir['*.gemspec'].first
gemspec = eval File.read(gemspec_file), binding, gemspec_file
info = "#{gemspec.name} | #{gemspec.version} | " \
"#{gemspec.runtime_dependencies.size} dependencies | " \
  "#{gemspec.files.size} files"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

desc "#{gemspec.name} | IRB"
task :irb do
  exec "irb -I ./lib -r #{gemspec.name.gsub '-','/'}"
end

task :default => :test
