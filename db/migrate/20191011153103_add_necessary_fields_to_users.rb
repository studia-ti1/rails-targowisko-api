class AddNecessaryFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      # TODO: validate this field in the model!
      t.string :phone_number, null: false
      t.boolean :active, null: false, default: true
    end
  end
end
