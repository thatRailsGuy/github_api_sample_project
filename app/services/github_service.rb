class GithubService
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize(org="lodash")
    @org = org
    @default_headers = {
      'Accept' => 'application/vnd.github.v3+json',
      'Authorization' => "token #{Figaro.env.github_token}",
      'User-Agent' => "#{Figaro.env.github_user}"}
  end

  def org
    self.class.get("/orgs/#{@org}", headers: @default_headers)
  end

  def repos
    self.class.get("/orgs/#{@org}/repos", headers: @default_headers)
  end

  def pulls(repo="lodash", state="all", page="1")
    self.class.get("/repos/#{@org}/#{repo}/pulls?state=#{state}&page=#{page}", headers: @default_headers)
  end

  def pull_commits(repo="lodash", number)
    self.class.get("/repos/#{@org}/#{repo}/pulls/#{number}/commits", headers: @default_headers)
  end

  def rate_limit
    self.class.get("/rate_limit", headers: @default_headers)
  end

  def time_until_rate_limit_clear
    response = JSON.parse rate_limit.body
    if response["resources"]["core"]["remaining"] == 0
      seconds = response["resources"]["core"]["reset"].to_i - Time.now.to_i + 10
      return seconds
    else
      return 0
    end
  end

  def all_pulls(repo="lodash", state="all")
    i = 1
    has_next = true
    while has_next do
      results = pulls(repo, state, i)
      if results.success?
        has_next = results.headers["link"].andand.include? 'rel="next"'
        results.each do |pull|
          yield pull
        end
        i += 1
      end
    end
  end
end
