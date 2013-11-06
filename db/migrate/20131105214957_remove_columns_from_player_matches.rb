class RemoveColumnsFromPlayerMatches < ActiveRecord::Migration
  def change
    remove_column :player_matches, :created_at
    remove_column :player_matches, :updated_at
    rename_column :player_matches, :core, :score
  end
end
