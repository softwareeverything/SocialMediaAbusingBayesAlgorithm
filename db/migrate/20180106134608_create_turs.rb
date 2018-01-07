class CreateTurs < ActiveRecord::Migration[5.1]
  def up
    create_table :turs do |t|
      t.boolean :tehdit, :null=>false
      t.boolean :kufur, :null=>false
      t.boolean :aldatma, :null=>false
      t.boolean :siddet, :null=>false
    end
  end

  def down
    drop_table :turs
  end
end
