# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101227132436) do

  create_table "field_objects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "type_id",     :default => 0
    t.integer  "x",           :default => 0
    t.integer  "y",           :default => 0
    t.integer  "process_end", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grow_period", :default => 1
  end

  add_index "field_objects", ["user_id"], :name => "index_field_objects_on_user_id"

  create_table "users", :force => true do |t|
    t.integer  "money",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size_x",     :default => 0
    t.integer  "size_y",     :default => 0
  end

  add_foreign_key "field_objects", "users", :name => "field_objects_user_id_fk"

end
