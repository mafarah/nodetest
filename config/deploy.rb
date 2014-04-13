role :app, "107.170.233.115"                          # This may be the same as your `Web` server

set :application, "nodetest"
set :deploy_to, "/var/www"
 
set :scm, :git
set :repository, "git@github.com:mafarah/nodetest.git"
 
default_run_options[:pty] = true
set :user, "node-test"
set :normalize_asset_timestamps, false
  
namespace :deploy do
	desc "Stop Forever"
	task :stop do
		run "forever stopall"
	end
	 
	desc "Start Forever"
	task :start do
		run "cd #{current_path} && forever start app.js"
		puts "current path #{current_path}"
	end
	 
	desc "Restart Forever"
	task :restart do
		stop
		sleep 5
		start
	end
	 
	desc "Refresh shared node_modules symlink to current node_modules"
	task :refresh_symlink do
		run "rm -rf #{current_path}/node_modules && ln -s #{shared_path}/node_modules #{current_path}/node_modules"
	end
	 
	desc "Install node modules non-globally"
		task :npm_install do
		run "cd #{current_path} && npm install"
	end
end
 
# after "deploy:update_code", "deploy:refresh_symlink", "deploy:npm_install"