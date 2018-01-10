class CreateYoneticis < ActiveRecord::Migration[5.1]
  def up
    create_table :yoneticis, id: false do |t|
      t.references :user, foreign_key: true
    end
  end

  def down
    drop_table :yoneticis
  end
end