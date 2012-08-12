class Food::PivotalTracker < Food  

  def initialize(attrs)
    @category = "Pivotal Tracker Stories"
    @type = "pivotal_tracker_story"
    super(attrs)
  end
 
end
