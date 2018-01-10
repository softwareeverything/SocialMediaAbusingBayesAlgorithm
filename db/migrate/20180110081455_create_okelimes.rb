class CreateOkelimes < ActiveRecord::Migration[5.1]
  def up
    create_table :okelimes do |t|
      t.string :ad, null:false, unique:true
      t.column :tehdit, :bigint
      t.column :kufur, :bigint
      t.column :aldatma, :bigint
      t.column :siddet, :bigint
      t.column :kayitsayisi, :bigint
      t.timestamps
    end
  end

  def down
    drop_table :okelimes
  end
end