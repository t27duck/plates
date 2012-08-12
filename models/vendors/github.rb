class Vendor::Github < Vendor
 
  def serve
    pull_requests.map{|pr| create_food(pr)}
  end

  private ######################################################################
  
  def food_class
    Food::Github
  end

  def pull_requests
    prep_api
    pull_requests = []
    @github.pull_requests.all(@github.user, @github.repo).each do |pr|
      next unless pr.user.login == user.github_login
      pull_requests << pr
    end
    pull_requests
  end

  def prep_api
    @github = ::Github.new( 
        :basic_auth => "#{CONFIG[:github][:login]}:#{CONFIG[:github][:password]}", 
        :repo => CONFIG[:github][:repo], :user => CONFIG[:github][:user]
    )
  end

  def food_fields(pull_request)
    {
      :title => pull_request.title,
      :state => pull_request.state,
      :description => pull_request.body,
      :misc_info => { },
      :created_at => Date.parse(pull_request.created_at),
      :updated_at => Date.parse(pull_request.updated_at),
      :url => pull_request.html_url,
      :remote_id => pull_request.id
    }
  end
end
