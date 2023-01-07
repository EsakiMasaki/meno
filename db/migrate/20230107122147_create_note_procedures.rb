class CreateNoteProcedures < ActiveRecord::Migration[6.1]
  def change
    create_table :note_procedures do |t|
      t.integer :customer_id
      t.integer :note_id
      t.string :procedure
      t.text :explanation

      t.timestamps
    end
  end
end
