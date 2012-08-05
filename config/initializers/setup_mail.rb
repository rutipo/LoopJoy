ActionMailer::Base.smtp_settings = {
  :address              => "email-smtp.us-east-1.amazonaws.com",
  :port                 => 587,
  :domain               => "loopjoy.com",
  :user_name            => "AKIAIONVWEARULAAG2ZQ",
  :password             => "Askr5SceS5lGmWK0xzqlwnAM8rNETDLZRFkK03alKVR2",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "loopjoy.com"