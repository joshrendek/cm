class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :sex, size: 1
      t.integer :age
      t.date :birthday
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
