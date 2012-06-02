class AddRoleToUser < ActiveRecord::Migration
  def self.up
    change_column :users, :role, :string, :default => 'Administrator'
  end
end
