class ModifyPrisonersAuth < ActiveRecord::Migration
  def up
    change_table :prisoners do |t|
      t.string :encrypted_password
      t.string :salt
    end
  end

  def down
    change_table :prisoners do |t|
      t.remove :encrypted_password, :salt
    end
  end
end
