class AddProjectReferenceToCollections < ActiveRecord::Migration[6.0]
  def change
    add_reference :collections, :project, null: false, foreign_key: true
  end
end
