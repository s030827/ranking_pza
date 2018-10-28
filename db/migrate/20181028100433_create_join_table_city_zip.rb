class CreateJoinTableCityZip < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cities, :zips do |t|
      t.index [:city_id, :zip_id]
      t.index [:zip_id, :city_id]
    end
  end
end
