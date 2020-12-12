class AddPeselToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :pesel, :string, unique: true
    add_index :decidim_users, :pesel, unique: true
  end
end
