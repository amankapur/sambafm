class RemoveUser < ActiveRecord::Migration
  drop_table :users
end
