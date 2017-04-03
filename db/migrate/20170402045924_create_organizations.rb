class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :login
      t.integer :gh_id
      t.string :name

      t.timestamps
    end
  end
end
