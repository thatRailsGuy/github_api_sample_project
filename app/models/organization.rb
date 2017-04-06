# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  login      :string
#  gh_id      :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ApplicationRecord
  has_many :repos, primary_key: "gh_id", foreign_key: "organization_gh_id"
  has_many :pulls, through: :repos

  def self.pull_from_github(org_name)
    org_data = JSON.parse GithubService.new(org_name).org.body
    org = create_from_json(org_data)
    org.pull_repos_from_github
  end

  def self.create_from_json(org_data)
    Organization.find_or_create_by!(name: org_data["name"], gh_id: org_data["id"],login: org_data["login"])
  end

  def pull_repos_from_github
    repos_json = JSON.parse GithubService.new(login).repos.body
    repos = []
    repos_json.each do |repo_data|
      repos << Repo.create_from_json(repo_data)
    end
    repos.each {|repo| repo.pull_pulls_from_github}
  end

  def closed_pulls
    Organization.first.pulls.merged.count
  end

  def three_months_stats
    stats = []
    (1..12).each do |x|
      stats << {x => {
        merged: pulls.merged_x_weeks_ago(x).count,
        average_merge_time: pulls.merged_x_weeks_ago(x).average_merge_time,
        median_merge_time: pulls.merged_x_weeks_ago(x).median_merge_time}}
    end
    stats
  end
end
