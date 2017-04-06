class AddFirstCommitToPull < ActiveRecord::Migration[5.0]
  def change
    add_column(:pulls, :first_commit_at, :datetime)
  end
end
