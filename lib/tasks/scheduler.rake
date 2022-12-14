# frozen_string_literal: true

desc 'This task is called by the Heroku scheduler add-on'
task send_pre_order_reminders: :environment do
  puts 'Sending reminders...'
  Order.reminder_send
  puts 'done.'
end
