# == Schema Information
#
# Table name: pulls
#
#  id               :integer          not null, primary key
#  gh_id            :integer
#  repo_gh_id       :integer
#  state            :string
#  gh_number        :integer
#  title            :string
#  body             :text
#  gh_created_at    :datetime
#  gh_updated_at    :datetime
#  gh_closed_at     :datetime
#  gh_merged_at     :datetime
#  merge_commit_sha :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  first_commit_at  :datetime
#

class Pull < ApplicationRecord
  belongs_to :repo, primary_key: "gh_id", foreign_key: "repo_gh_id"
  scope :merged, -> { where.not(gh_merged_at: nil) }
  scope :unmerged, -> { where(gh_merged_at: nil) }

  def self.create_from_json(pull_data)
    pull = Pull.find_or_create_by!(gh_id: pull_data["id"], repo_gh_id: pull_data["base"]["repo"]["id"])
    commit_data = JSON.parse GithubService.new(pull.repo.organization.login).pull_commits(pull.repo.name, pull_data["number"]).body
    unless commit_data.empty?
      commit_data.sort_by{|commit| commit["commit"]["author"]["date"]}.first
      pull_data["first_commit"] = commit_data.first["commit"]["author"]["date"]
    end
    pull.update!(
      state: pull_data["state"],
      gh_number: pull_data["number"],
      title: pull_data["title"],
      body: pull_data["body"],
      merge_commit_sha: pull_data["merge_commit_sha"],
      gh_created_at: pull_data["created_at"],
      gh_updated_at: pull_data["updated_at"],
      gh_closed_at: pull_data["closed_at"],
      gh_merged_at: pull_data["merged_at"],
      first_commit_at: pull_data["first_commit"])
    pull
  end

  def self.merged_x_weeks_ago(x)
    self.where(gh_merged_at: x.week.ago.beginning_of_week..(x-1).weeks.ago.beginning_of_week)
  end

  def self.average_merge_time
    count = self.count
    return 0 if count == 0
    sum = 0
    self.merged.each do |pull|
      sum += pull.gh_merged_at - pull.gh_created_at
    end
    sum / count
  end

  def self.median_merge_time
    count = self.count
    return 0 if count == 0
    pulls = self.merged.map { |pull| pull.gh_merged_at - pull.gh_created_at }.sort.reverse
    pulls[pulls.count/2]
  end

  def merged?
    !gh_merged_at.nil?
  end
end
