class CreateApiRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :api_requests do |t|
      t.timestamps null: false
      t.text :url, null: false
      t.text :response, null: false
    end

    add_index :api_requests, :url, unique: true
  end
end
