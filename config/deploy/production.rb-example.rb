#############################################################
#	Application
#############################################################

set :application, "holiday-mailer"
set :deploy_to, "/path/to/deploy"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, true
set :scm_verbose, true
set :rails_env, "production" 

#############################################################
#	Servers
#############################################################

set :user, "holiday-mailer"
set :domain, "www.example.com"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Git
#############################################################

set :scm, :git
set :branch, "master"
set :scm_user, 'set_me'
set :scm_passphrase, "PASSWORD"
set :repository, "git@github.com:you/holiday-mailer.git"
set :deploy_via, :remote_cache

#############################################################
#	Passenger
#############################################################

namespace :deploy do
  desc "Symlink config files"
  task :before_symlink do
    run "mkdir -p #{shared_path}/config/initializers"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
    run "ln -s #{shared_path}/config/default_body.erb #{release_path}/config/default_body.erb"
    run "ln -s #{shared_path}/config/initializers/smtp_settings.rb #{release_path}/config/initializers/smtp_settings.rb"
  end

  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
end
