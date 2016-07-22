class CreateFlows < ActiveRecord::Migration[5.0]
  def change
    create_table :flows do |t|
      t.references :user, foreign_key: true
      t.string :payload, null: false
      t.string :flow_tag, null: false
      t.integer :flow_type, null: false

      t.timestamps
    end
  end
end
