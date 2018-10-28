class CreateZips < ActiveRecord::Migration[5.1]
  def change
    create_table :zips do |t|
      t.string :code
      t.references :city, foreign_key: true
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6

      t.timestamps
    end
  end
end
