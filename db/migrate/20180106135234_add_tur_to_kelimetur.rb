class AddTurToKelimetur < ActiveRecord::Migration[5.1]
  def up
    add_reference :kelimeturs, :tur, foreign_key: true
  end

  def down
    remove_reference :kelimeturs, :tur
  end
end