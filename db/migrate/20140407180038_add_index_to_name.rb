class AddIndexToName < ActiveRecord::Migration
  def change
    add_index :contacts, :name
  end
end
