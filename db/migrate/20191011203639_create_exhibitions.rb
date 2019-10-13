# frozen_string_literal: true

class CreateExhibitions < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibitions do |t|
      t.string :name
      t.timestamps
    end
  end
end
