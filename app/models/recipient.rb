class Recipient < ActiveRecord::Base
  has_many :email_recipients
  has_many :emails, through: :email_recipients
end