class AddContactIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :contact_id, :integer
    add_index :addresses, :contact_id
  end
end
