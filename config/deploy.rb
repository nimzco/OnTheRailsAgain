require "bundler/capistrano"
set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :normalize_asset_timestamps, false
set :domain, "ontherailsagain.com"
set :application, "OnTheRailsAgain"
set :deploy_to, "/opt/www/OnTheRailsAgain"
set :user, "ec2-user"

set :repository,  "git@github.com:nim1989/OnTheRailsAgain.git"

set :scm, :git

set :use_sudo, false

server "ec2-user@ec2-50-19-204-4.compute-1.amazonaws.com", :app, :web, :db, :primary => true
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/OnTheRailsAgain.pem"]


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:

after "deploy:update", "assets:compile"

namespace :articles do
  task :update do
    run "cd #{release_path}; rake generate_articles RAILS_ENV=production "
  end
end
namespace :assets do
  task :compile do
    run "cd #{release_path}; rake assets:precompile RAILS_ENV=production "
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join current_path,'tmp','restart.txt'}"
  end
end
