set :application, "gordcooke"
set :location, "optim.emsolutions.ca"

set :user, "gordcook"
set :port, 22
default_run_options[:pty] = true

role :app, location
role :web, location
role :db, location, :primary => true

task :sync, :roles => :db, :only => { :primary => true } do
  require 'yaml' 
  database = YAML::load_file('config/database.yml')

  stage = 'production'
  current_path = 'gordcooke'
  
  db_filename = "#{application}_#{stage}_dump.#{Time.now.strftime '%Y%m%d%H%M%S'}.sql"
  on_rollback { delete "/tmp/#{db_filename}" }
 
  run "mysqldump -u #{database[stage.to_s]['username']} --password=#{database[stage.to_s]['password']} #{database[stage.to_s]['database']} | gzip -c > /tmp/#{db_filename}.gz"
  get "/tmp/#{db_filename}.gz", "#{db_filename}.gz"

  cmds = [
    "gunzip #{db_filename}.gz",
    "mysql -u #{database['development']['username']} --password=#{database['development']['password']} #{database['development']['database']} < #{db_filename}",
    "rm #{db_filename}",
    "rsync -avz -e \"ssh -p #{port}\" --delete #{user}@#{location}:#{current_path}/public/images/* public/images/",
    "rsync -avz -e \"ssh -p #{port}\" --delete #{user}@#{location}:#{current_path}/public/uploads/* public/uploads/"
  ]

  exec cmds.join("; ")
end