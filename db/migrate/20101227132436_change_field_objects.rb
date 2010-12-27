class ChangeFieldObjects < ActiveRecord::Migration
  def self.up
  	add_column(:field_objects, :grow_period, :integer, :default=>1)
  end

  def self.down
  	remove_column(:field_objects, :grow_period)
  end
end
