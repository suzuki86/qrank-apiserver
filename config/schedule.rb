ENV.each { |k, v| env(k, v) }

set :environment, :production

job_type :runner, "cd :path && rails runner -e :environment :task"

set :job_template, ":job"

every 10.minutes do
  runner 'QrankRunner.get_entries'
end

every "3 * * * *" do
  runner '"QrankRunner.get_entries(2)"'
end

every "5 * * * *" do
  runner '"QrankRunner.get_entries(3)"'
end

every "7 * * * *" do
  runner '"QrankRunner.get_entries(4)"'
end

every "9 * * * *" do
  runner '"QrankRunner.get_entries(5)"'
end

every "11 * * * *" do
  runner '"QrankRunner.get_entries(7)"'
end

every "13 * * * *" do
  runner '"QrankRunner.get_entries(10)"'
end

every "15 * * * *" do
  runner '"QrankRunner.get_entries(15)"'
end

every "17 * * * *" do
  runner '"QrankRunner.get_entries(20)"'
end

every "19 * * * *" do
  runner '"QrankRunner.get_entries(25)"'
end

every "21 * * * *" do
  runner '"QrankRunner.get_entries(30)"'
end

every "23 * * * *" do
  runner '"QrankRunner.get_entries(40)"'
end

every "25 * * * *" do
  runner '"QrankRunner.get_entries(50)"'
end

every 2.minutes do
  runner 'QrankRunner.update_entry'
end

every "9,19,29,39,49,59 * * * *" do
  runner 'QrankRunner.update_user'
end
