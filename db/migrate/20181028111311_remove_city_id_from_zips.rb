class RemoveCityIdFromZips < ActiveRecord::Migration[5.1]
  def change
    remove_column :zips, :city_id, :integer
  end
end
