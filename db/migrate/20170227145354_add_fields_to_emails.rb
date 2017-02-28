class AddFieldsToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :timestamp, :datetime
    add_column :emails, :subject, :string, array: true

    # add index to speed up queries with timestamps
    add_index :emails, :timestamp
  end
end
