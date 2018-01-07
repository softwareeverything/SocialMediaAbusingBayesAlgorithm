class CreateKelimes < ActiveRecord::Migration[5.1]
  def up
    create_table :kelimes do |t|

    end
  end

  def down
    drop_table :kelimes
  end
end
