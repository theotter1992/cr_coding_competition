class AddFieldsToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :email, :string

    # speeed up queries with emails
    add_index :recipients, :email, unique: true
  end
end
