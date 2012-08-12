class Food::Github < Food
  def initialize(attrs)
    @category = "GitHub Pull Requests"
    @type = "github_pull_requests"
    super(attrs)
  end
end
