require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install, :module do |t, args|
  path = args.module ? "modules/#{args.module}/" : ''
  replace_all = false
  Dir[path + '*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE modules].include? file
    filename = file.sub(path, '').sub('.erb', '')
    puts File.join(ENV['HOME'], ".#{filename}")
    
    if File.exist?(File.join(ENV['HOME'], ".#{filename}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{filename}")
        puts "identical ~/.#{filename}"
      elsif replace_all
        replace_file(file, filename)
      else
        print "overwrite ~/.#{filename}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file, filename)
        when 'y'
          replace_file(file, filename)
        when 'q'
          exit
        else
          puts "skipping ~/.#{filename}"
        end
      end
    else
      link_file(file, filename)
    end
  end
end

def replace_file(file, filename)
  system %Q{rm -rf "$HOME/.#{filename}"}
  link_file(file, filename)
end

def link_file(file, filename)
  if file =~ /.erb$/
    puts "generating ~/.#{filename}"
    File.open(File.join(ENV['HOME'], ".#{filename}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{filename}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{filename}"}
  end
end
