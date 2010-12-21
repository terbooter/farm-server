class AddSizeColumns < ActiveRecord::Migration
  def self.up
  	add_column(:users, :size_x, :integer, :default=>0)
  	add_column(:users, :size_y, :integer, :default=>0)
  end

  def self.down
  	remove_column(:users, :size_x)
  	remove_column(:users, :size_y)
  end
end
