set :location, "loopjoy.com"
role :web, location
role :app, location
role :db,  location, :primary => true