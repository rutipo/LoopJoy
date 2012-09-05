set :stages, %w(production development)
set :default_stage, "development"
require 'capistrano/ext/multistage'

set :user, "thinds"
set :location, "loopjoy.com"
set :application, "lj"
set :deploy_to, "/home/thinds/apps/lj"


set :scm, :git
set :repository,  "git@github.com:rutipo/LoopJoy.git"
ssh_options[:forward_agent] = true

set :branch,"master"
set :deploy_via, :remote_cache

role :web, location
role :app, location
role :db,  location, :primary => true

#To stop ugly error messages in assets
set :normalize_asset_timestamps, false 


namespace :deploy do
  task :start, :roles => :app do
  	
  	run "rake db:migrate"
    run "sudo service thin start"
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