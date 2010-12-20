class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :id=>true do |t|
      
      #Пока делаем для ВК, но имеем ввиду что ММ и ОК
      #хотят unsignt bigint
      #t.integer :uid
      t.integer :money, :default=>0
      t.timestamps
    end
    #add_index(:users, :uid, :primary => true)
    #primary_key("uid")
    
  end

  def self.down
    drop_table :users
  end
end
