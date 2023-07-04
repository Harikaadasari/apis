class CreateApis < ActiveRecord::Migration[6.0]
#   def change
#     create_table :apis do |t|
#       t.string :name
#       t.string :method
#       t.string :path
#       t.string :requestheader
#       t.string :requestbody
#       t.references :collection, null: false, foreign_key: true

#       t.timestamps
#     end
#     add_index :apis, :collection_id

#   end
# end


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
