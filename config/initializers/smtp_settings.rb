ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            'act.navin@gmail.com',
  password:             'baliyase@007',
  authentication:       :plain,
  enable_starttls_auto: true
}
