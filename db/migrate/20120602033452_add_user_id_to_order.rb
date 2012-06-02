class AddUserIdToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :user_id, :integer, :default => -1
  end
  def self.down
    remove_column :orders, :user_id
  end
end
