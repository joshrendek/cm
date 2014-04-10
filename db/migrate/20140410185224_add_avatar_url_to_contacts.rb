class AddAvatarUrlToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :avatar_url, :string
  end
end
