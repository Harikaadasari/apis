class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      # t.references :collection, foreign_key: true

      t.timestamps
    end
  end
end

