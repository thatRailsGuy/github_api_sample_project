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
end
