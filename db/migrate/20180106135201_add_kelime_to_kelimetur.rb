class AddKelimeToKelimetur < ActiveRecord::Migration[5.1]
  def up
    add_reference :kelimeturs, :kelime, foreign_key: true
  end

  def down
    remove_reference :kelimeturs, :kelime
  end
end