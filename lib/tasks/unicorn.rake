namespace :unicorn do
  desc "Start Unicorn"
  task :start => :environment do
    config = Rails.root + "config/unicorn.rb"
    sh "bundle exec unicorn_rails -c #{config} -E development -D"
  end
  desc "Stop Unicorn"
  task :stop => :environment do
    pid = File.read(Rails.root + "tmp/pids/unicorn.pid").to_i
    Process.kill(:QUIT, pid)
  end
end
