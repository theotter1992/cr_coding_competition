class Email < ActiveRecord::Base
  # use has many through joint table
  # to be more flexible if joint relationship needs later on more information
  has_many :email_recipients
  has_many :recipients, through: :email_recipients
end