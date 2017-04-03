class CreatePulls < ActiveRecord::Migration[5.0]
  def change
    create_table :pulls do |t|
      t.integer :gh_id
      t.integer :repo_gh_id
      t.string :state
      t.integer :gh_number
      t.string :title
      t.text :body
      t.datetime :gh_created_at
      t.datetime :gh_updated_at
      t.datetime :gh_closed_at
      t.datetime :gh_merged_at
      t.string :merge_commit_sha

      t.timestamps
    end
  end
end
