class CreateKelimeads < ActiveRecord::Migration[5.1]
  def up
    create_table :kelimeads do |t|
      t.string :ad, :null=>false
    end
    add_index :kelimeads, :ad, unique: true
  end

  def down
    drop_table :kelimeads
  end
end
