APP_CONFIG = {
  site_url: 'http://holiday-mailer.heroku.dev',
  site_name: 'Holiday Mailer',
  admin_email: 'luke@lukemelia.com',
  default_subject: "Happy New Year!",
  default_from: "Luke & Jeanhee <lukeandjeanhee@lukemelia.com>",
  default_image_filename: "happy-new-year-2008-9.jpg"
}

if Rails.env.production?
  APP_CONFIG[:site_url] = 'https://holiday-mailer.heroku.com'
end