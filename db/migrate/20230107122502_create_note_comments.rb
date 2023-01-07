class CreateNoteComments < ActiveRecord::Migration[6.1]
  def change
    create_table :note_comments do |t|
      t.integer :customer_id
      t.integer :note_id
      t.text :comment
      t.integer :post_status

      t.timestamps
    end
  end
end
