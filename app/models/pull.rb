class Pull < ApplicationRecord
  belongs_to :repo, primary_key: "gh_id", foreign_key: "repo_gh_id"

  def self.create_from_json(pull_data)
    pull = Pull.find_or_create_by!(gh_id: pull_data["id"], repo_gh_id: pull_data["base"]["repo"]["id"])
    pull.update!(
      state: pull_data["state"],
      gh_number: pull_data["number"],
      title: pull_data["title"],
      body: pull_data["body"],
      merge_commit_sha: pull_data["merge_commit_sha"],
      gh_created_at: pull_data["created_at"],
      gh_updated_at: pull_data["updated_at"],
      gh_closed_at: pull_data["closed_at"],
      gh_merged_at: pull_data["merged_at"])
    pull
  end
end
