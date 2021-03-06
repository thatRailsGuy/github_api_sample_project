# == Schema Information
#
# Table name: repos
#
#  id                 :integer          not null, primary key
#  gh_id              :integer
#  name               :string
#  organization_gh_id :integer
#  description        :string
#  gh_created_at      :datetime
#  gh_updated_at      :datetime
#  gh_pushed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Repo < ApplicationRecord
  belongs_to :organization, primary_key: "gh_id", foreign_key: "organization_gh_id"
  has_many :pulls, primary_key: "gh_id", foreign_key: "repo_gh_id"

  def self.create_from_json(repo_data)
    repo = Repo.find_or_create_by!(gh_id: repo_data["id"], organization_gh_id: repo_data["owner"]["id"])
    repo.update!(name: repo_data["name"], description: repo_data["description"], gh_created_at: repo_data["created_at"], gh_updated_at: repo_data["updated_at"], gh_pushed_at: repo_data["pushed_at"])
    repo
  end

  def pull_pulls_from_github
    GithubService.new(organization.login).all_pulls(name, "all"){|pull_data| Pull.create_from_json(pull_data)}
  end

  def closed_pulls
    pulls.merged.count
  end
end
