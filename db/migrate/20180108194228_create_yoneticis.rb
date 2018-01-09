class CreateYoneticis < ActiveRecord::Migration[5.1]
  def up
    create_table :yoneticis do |t|
      t.references :user, foreign_key: true
    end
  end

  def down
    remove_reference :user
    drop_table :yoneticis
  end
end