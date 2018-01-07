class CreateKelimeturs < ActiveRecord::Migration[5.1]
  def up
    create_table :kelimeturs do |t|

    end
  end

  def down
    drop_table :kelimeturs
  end
end
