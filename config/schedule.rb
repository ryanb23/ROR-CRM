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
every :day do
  runner "User.send_mail_about_expire_insurance"
end
every 1.minute do # 1.minute 1.day 1.week 1.month 1.year is also supported
	set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
  runner "Form.check_status_of_uploaded_file_every_minute"
end

every :hour do
  runner "Form.check_status_of_uploaded_file_every_hour"
end

# every 1.day do
# 	runner "Form.check_status_of_uploaded_file_every_day"
# end

# Learn more: http://github.com/javan/whenever
