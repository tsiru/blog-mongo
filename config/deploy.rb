set :rvm_ruby_string, "2.0.0"

require "bundler/capistrano"
require "capistrano_colors"
require 'rvm/capistrano'
require 'capistrano-unicorn'

load "deploy/assets"

ssh_options[:port]          = 22
ssh_options[:forward_agent] = true

set :user,   'blog-mongo'
set :domain, 'tsiru.pl'

set :branch, `git rev-parse --abbrev-ref HEAD`

set(:deploy_to) { "/home/#{user}/application" }

set(:bundledir)     { File.join(fetch(:shared_path), 'bundle') }
set(:copy_exclude)  { ['.git'] }
set(:keep_releases) { 5 }
set(:application)   { "tarnus" }
set(:repository)    { "git@bitbucket.org:tsiru/blog-mongo.git" }
set(:scm)           { :git }
set(:scm_verbose)   { true }
set(:deploy_via)    { :remote_cache }
set(:rails_env)     { "production" }
set(:use_sudo)      { false }

role(:app, primary: true) { domain }
role(:web, primary: true) { domain }
role(:db,  primary: true) { domain }

namespace :deploy do
  desc 'Copies all the settings files that are required to run application'
  task :settings do
    run "cp -Rvf #{shared_path}/untracked_files/ #{release_path}"
  end
end

before 'deploy:setup',  'rvm:install_rvm'  # install/update RVM
before 'deploy:setup',  'rvm:install_ruby' # install Ruby and create gemset, OR:
before 'deploy:update', 'deploy:settings'
after  'deploy:update', 'deploy:migrate'
after  'deploy:update', 'deploy:cleanup'
