class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|

      t.integer :directory_id
      t.string :file

      t.timestamps
    end
  end
end
