class CreateFieldObjects < ActiveRecord::Migration
	
  def self.up
    create_table :field_objects do |t|
	  #t.integer "user_id"
	  t.references :user
	  t.integer :type_id, :default=>0
	  t.integer :x, :default=>0
	  t.integer :y, :default=>0
	  #По-хорошему это надо вынести в таблицу plants, но не будем пока усложнять
	  t.integer :process_end, :default=>0
      t.timestamps
    end
    add_index(:field_objects, :user_id)
    #gem foreigner
    add_foreign_key(:field_objects, :users)
    
  end

  def self.down
    drop_table :field_objects
  end
end
