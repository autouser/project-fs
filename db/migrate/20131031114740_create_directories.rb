class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :name
      t.string :ancestry
      t.integer :project_id

      t.timestamps
    end

    add_index :directories, :ancestry

  end
end
