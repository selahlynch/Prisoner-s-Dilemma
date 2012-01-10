class CreatePrisoners < ActiveRecord::Migration
  def change
    create_table :prisoners do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
