class AddKelimeadToKelime < ActiveRecord::Migration[5.1]
  def up
    add_reference :kelimes, :kelimead, foreign_key: true
  end

  def down
    remove_reference :kelimes, :kelimead
  end
end