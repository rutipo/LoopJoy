set :stages, %w(development production)
set :default_stage, "development"
require 'capistrano/ext/multistage'

set :user, "thinds"
set :application, "lj"
set :deploy_to, "/home/thinds/apps/lj"


set :scm, :git
set :repository,  "git@github.com:rutipo/LoopJoy.git"
ssh_options[:forward_agent] = true

set :branch,"master"
set :deploy_via, :remote_cache

#To stop ugly error messages in assets
set :normalize_asset_timestamps, false 


namespace :deploy do
  task :start, :roles => :app do
  	
  	run "rake db:migrate"
    run "service thin start"
  end

  task :stop, :roles => :app do
    run "service thin stop"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "service thin stop"
    run "service thin start"
  end
end