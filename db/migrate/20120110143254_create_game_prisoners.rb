class CreateGamePrisoners < ActiveRecord::Migration
  def change
    create_table :game_prisoners do |t|
      #t.integer :id ##should be done automatically?
      t.references :prisoner, :null => false
      t.references :game, :null => false
      t.boolean :confess

      t.timestamps
    end
    add_index :game_prisoners, [:game_id, :prisoner_id], :unique => true

  end
end
