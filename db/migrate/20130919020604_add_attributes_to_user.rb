class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :banned, :boolean, default: false
    add_column :users, :contest_creator, :boolean, default: false
  end
end
