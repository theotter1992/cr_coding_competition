class EmailRecipient < ActiveRecord::Base
  belongs_to :email
  belongs_to :recipient
end
