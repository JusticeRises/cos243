class CreatePlayerMatches < ActiveRecord::Migration
  def change
    create_table :player_matches do |t|
      t.references :player, index: true
      t.references :match, index: true
      t.float :core
      t.string :result

      t.timestamps
    end
  end
end
