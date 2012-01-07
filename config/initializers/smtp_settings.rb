ActionMailer::Base.smtp_settings = {
  :perform_deliveries => true,
  :address            => 'smtp.sendgrid.net',
  :port               => 25,
  :domain             => 'holiday.lukemelia.com',
  :user_name          => ENV['HOLIDAY_MAILER_SENDGRID_USERNAME'],
  :password           => ENV['HOLIDAY_MAILER_SENDGRID_PASSWORD'],
  :authentication     => :plain
}
