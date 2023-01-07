class RemoveCustomerIdFromNoteProcedures < ActiveRecord::Migration[6.1]
  def change
    remove_column :note_procedures, :customer_id, :integer
  end
end
