class CreateExhibitions < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibitions do |t|
      t.string :name
    end
  end
end
