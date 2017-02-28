require 'active_record'
require 'activerecord-import'


# basically I split up the data into recipient & email that are connected through a many2many relationship
# in that way I reduce redudandancy & easier to access specific recipient and his emails

class ApiController < ApplicationController

  # in order to make it fast, I tried to use SQL inserts instead of saving each record manually
  # in that way all records can be saved with one query
  # disadvantage: its less readable but as this is a challenge I tried to make it more performant
  def upload_emails
    # if fails rolls back everything
    # avoids inconsistent state of DB
    ActiveRecord::Base.transaction do
      emails, recipients_hash = collect_data(JSON.parse(request.body.read)['emails'])
      recipient_mails = recipients_hash.keys

      # use activerecord-import gem to nicely insert a lot of records
      # I thought about setting the new ids by myself, but its prone to race-conditions
      # so I let the DB do this job & just retrieve ids of inserted records    
      email_ids = Email.import(emails).ids
      # update counter_unique_subject_words if we want to insert existing recipient
      Recipient.import(recipients_hash.values, on_duplicate_key_update: [:counter_unique_subject_words])
      recipient_ids = Recipient.where(email: recipient_mails).order(:id).pluck(:id)

      # in order to establish many2many relationship, set ids of records
      # and save them into the joint table in one query
      emails.each_with_index do |email, idx|
        email.id = email_ids[idx]
      end
      recipients_hash.values.each_with_index do |recipient, idx|
        recipient.id = recipient_ids[idx]
      end

      # insert ids into joint table
      query_email_recipients = "INSERT INTO email_recipients (created_at, updated_at, email_id, recipient_id) VALUES #{email_recipients_to_query(emails)}"
      ActiveRecord::Base.connection.insert(query_email_recipients)
    end
    render(json: nil)
  end

  # collect all the emails, recipients from json
  def collect_data(emails_json)
    emails = []
    recipients = {}
    emails_json.each do |email_json|
      subject = process_subject(email_json['subject'])
      emails.push(Email.new(timestamp: email_json['timestamp'], subject: subject))
      email_json['recipients'].uniq.each do |recipient_email|
        if !recipients.key?(recipient_email)
          recipients[recipient_email] = Recipient.find_or_initialize_by(email: recipient_email)
        end
        recipients[recipient_email].counter_unique_subject_words += subject.uniq.size        
        emails.last.recipients << recipients[recipient_email]
      end
    end
    [emails, recipients]
  end

  # remove symbols
  # upcase words to make queries easier
  # put subject into array
  def process_subject(subject)
    subject = subject.gsub(/\'|\?|!|\.|,|;|\+|-|_/, "")
    subject.upcase.split(' ')
  end

  # convert models into values to insert them
  def email_recipients_to_query(emails)
    values = []
    emails.each do |email|
      email.recipients.each do |recipient|
        values += ["('#{Time.now}', '#{Time.now}', #{email.id}, #{recipient.id})"]
      end
    end
    values.join(',')
  end
end