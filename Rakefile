#!/usr/bin/env ruby

require "bundler/setup"
require 'rake'
require 'fileutils'

Bundler.require

task :default => :install

desc "Install the dotfiles into the user's home directory"
task :install => :git_submodules do
  linkables = Dir.glob('*/**{.symlink}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv -v "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end

    `ln -vns "$PWD/#{linkable}" "#{target}"` unless File.symlink?(target)
  end
end

desc "Pull git submodules"
task :git_submodules do
  puts "Initializing submodules..."
  sh "git submodule sync"
  sh "git submodule init"
  sh "git submodule update"
end

desc "Update VIM bundles"
task :vimupdate => :git_submodules do
  sh "git submodule update"
  sh "git submodule foreach git checkout master"
  sh "git submodule foreach git reset --hard"
  sh "git submodule foreach git clean -fdx"
  sh "git submodule foreach git pull origin master"
  puts "Done!"
end


desc "Remove the dotfiles from the user's home directory"
task :uninstall do

  Dir.glob('**/*.symlink').each do |linkable|

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"` 
    end

  end
end