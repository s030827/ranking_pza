class CreateAscents < ActiveRecord::Migration[5.1]
  def change
    create_table :ascents do |t|
      t.references :user, foreign_key: true
      t.references :line, foreign_key: true
      t.string :style
      t.date :date
      t.string :kind
      t.string :belayer

      t.timestamps
    end
  end
end
