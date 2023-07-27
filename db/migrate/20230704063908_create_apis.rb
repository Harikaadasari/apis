class CreateApis < ActiveRecord::Migration[6.0]

    create_table :apis do |t|
      t.string :name
      t.integer :collection_id
      t.string :method
      t.string :path
      t.text :request_header
      t.text :request_body

      t.timestamps
    end

    add_index :apis, :collection_id
  end
