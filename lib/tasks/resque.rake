namespace :resque do
  task :setup => :environment do
    ENV["QUEUE"] ||= '*'
    Resque.before_fork = Proc.new {
      ActiveRecord::Base.establish_connection 
      #Resque.redis.client.reconnect
    }
    #Resque.schedule = YAML.load_file("#{Rails.root}/config/scheduler.yml")
  end
end
