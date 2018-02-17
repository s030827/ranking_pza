class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.string :name
      t.string :grade
      t.string :crag
      t.string :kind

      t.timestamps
    end
  end
end
