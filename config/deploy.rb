set :application, "lj"
set :repository,  "git@github.com:rutipo/LoopJoy.git"
set :deploy_to, "/home/thinds/apps/lj"

set :scm, :git
set :user, "thinds"

set :location, "23.21.115.125"

ssh_options[:forward_agent] = true

set :branch,"master"
set :deploy_via, :remote_cache
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, location                         # Your HTTP server, Apache/etc
role :app, location                          # This may be the same as your `Web` server
role :db,  location, :primary => true # This is where Rails migrations will run

set :normalize_asset_timestamps, false #To stop ugly error messages in assets

namespace :deploy do
  task :start, :roles => :app do
  	
  	run "rake db:migrate"
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end