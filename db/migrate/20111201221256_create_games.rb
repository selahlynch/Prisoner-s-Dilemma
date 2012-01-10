class CreateGames < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.integer :id
      t.string :name
      t.integer :player1_id
      t.integer :player2_id
      t.boolean :player1_confess
      t.boolean :player2_confess

      t.timestamps
    end
  end
  def down
    drop_table :games
  end
end
