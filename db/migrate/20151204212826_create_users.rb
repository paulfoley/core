class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :org_id
      t.timestamps null: false
      t.json :settings
      t.string :position
    end
  end
end
