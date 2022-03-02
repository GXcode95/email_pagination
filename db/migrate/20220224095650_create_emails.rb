class CreateEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :emails do |t|
      t.string :object
      t.string :recipient
      t.string :sender
      t.text :content

      t.timestamps
    end
  end
end
