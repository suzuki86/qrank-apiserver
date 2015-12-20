# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :environment, :production

every 10.minutes do
  runner 'QrankRunner.get_entries'
end

every "3 * * * *" do
  runner 'QrankRunner.get_entries(2)'
end

every "5 * * * *" do
  runner 'QrankRunner.get_entries(3)'
end

every "7 * * * *" do
  runner 'QrankRunner.get_entries(4)'
end

every "9 * * * *" do
  runner 'QrankRunner.get_entries(5)'
end

every "11 * * * *" do
  runner 'QrankRunner.get_entries(7)'
end

every "13 * * * *" do
  runner 'QrankRunner.get_entries(10)'
end

every "15 * * * *" do
  runner 'QrankRunner.get_entries(15)'
end

every "17 * * * *" do
  runner 'QrankRunner.get_entries(20)'
end

every "19 * * * *" do
  runner 'QrankRunner.get_entries(25)'
end

every "21 * * * *" do
  runner 'QrankRunner.get_entries(30)'
end

every "23 * * * *" do
  runner 'QrankRunner.get_entries(40)'
end

every "25 * * * *" do
  runner 'QrankRunner.get_entries(50)'
end

every 2.minutes do
  runner 'QrankRunner.update_entry'
end

every "9,19,29,39,49,59 * * * *" do
  runner 'QrankRunner.update_user'
end
