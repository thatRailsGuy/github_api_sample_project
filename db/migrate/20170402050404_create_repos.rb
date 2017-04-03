class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.integer :gh_id
      t.string :name
      t.integer :organization_gh_id
      t.string :description
      t.datetime :gh_created_at
      t.datetime :gh_updated_at
      t.datetime :gh_pushed_at

      t.timestamps
    end
  end
end
