class GithubService
  include HTTParty
  base_uri 'https://api.github.com'
  @default_headers = {'Accept' => 'application/vnd.github.v3+json'}

  def initialize(org="lodash")
    @org = org
  end

  def repos
    self.class.get("/orgs/#{@org}/repos")
  end

  def pulls(repo="lodash", state="all", page="1")
    self.class.get("/repos/#{@org}/#{repo}/pulls?state=#{state}&page=#{page}", options: {headers: @default_headers})
  end
end
