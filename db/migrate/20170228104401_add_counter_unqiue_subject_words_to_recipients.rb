class AddCounterUnqiueSubjectWordsToRecipients < ActiveRecord::Migration
  def change
    # add a counter for the number of unique subject words to that have been sent
    # avoids recomputation
    add_column :recipients, :counter_unique_subject_words, :integer, default: 0
  end
end
