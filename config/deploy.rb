require "bundler/capistrano"
require "capistrano_colors"
require 'rvm/capistrano'

load "deploy/assets"

ssh_options[:port]          = 22
ssh_options[:forward_agent] = true


server "tsiru.pl", :app, :web, :db, primary: true

set :branch, `git rev-parse --abbrev-ref HEAD`
set :rvm_ruby_string, "2.0.0"

set :use_sudo, false
set :application, "blog-mongo"

set :scm, :git
set :repository, "git@bitbucket.org:tsiru/blog-mongo.git"

set :user, "blog-mongo"
set :deploy_via, :remote_cache
set :deploy_to, "/home/blog-mongo/application"

after "deploy:restart", "deploy:cleanup"
