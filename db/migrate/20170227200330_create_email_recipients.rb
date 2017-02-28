class CreateEmailRecipients < ActiveRecord::Migration
  def change
    create_table :email_recipients do |t|
      t.references :email, index: true
      t.references :recipient, index: true

      t.timestamps null: false
    end
    add_foreign_key :email_recipients, :emails
    add_foreign_key :email_recipients, :recipients
  end
end
