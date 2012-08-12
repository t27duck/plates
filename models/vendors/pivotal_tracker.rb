class Vendor::PivotalTracker < Vendor
 
  def serve
    stories.map{|story| create_food(story)}
  end

  private ######################################################################
  
  def food_class
    Food::PivotalTracker
  end

  def stories
    prep_api
    project = ::PivotalTracker::Project.find(CONFIG[:pivotal_tracker][:project_id])
    states = %w{unscheduled unstarted started finished delivered}
    @stories = project.stories.all(:owner => user.pivotal_tracker_name, :state => states)
  end

  def prep_api
    ::PivotalTracker::Client.token = CONFIG[:pivotal_tracker][:api_token]
    ::PivotalTracker::Client.use_ssl = CONFIG[:pivotal_tracker][:always_use_ssl]
  end

  def food_fields(story)
    {
      :title => story.name,
      :state => story.current_state,
      :description => story.description,
      :misc_info => {
        :story_type => story.story_type,
        :estimate => story.estimate
      },
      :created_at => story.created_at,
      :url => story.url,
      :remote_id => story.id
    }
  end
end
