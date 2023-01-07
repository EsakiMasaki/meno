class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :can
      t.text :conclude
      t.text :necessities
      t.integer :publish_status
      t.integer :category_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
