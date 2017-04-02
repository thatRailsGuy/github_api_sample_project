class GithubService
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize(org="lodash")
    @org = org
    @default_headers = {'Accept' => 'application/vnd.github.v3+json'}
    @default_options = {headers: @default_headers, Authorization: "token #{Figaro.env.github_token}"}
  end

  def repos
    self.class.get("/orgs/#{@org}/repos", options: @default_options)
  end

  def pulls(repo="lodash", state="all", page="1")
    self.class.get("/repos/#{@org}/#{repo}/pulls?state=#{state}&page=#{page}", options: @default_options)
  end

  def all_pulls(repo="lodash", state="all")
    i = 1
    has_next = true
    while has_next do
      results = pulls(repo, state, i)
      has_next = results.headers["link"].include? 'rel="next"'
      results.each do |pull|
        yield pull
      end
      i += 1
    end
  end
end
