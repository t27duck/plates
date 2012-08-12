class Plate
  attr_reader :food

  def initialize(user)
    @user = user
    @food ||= []
  end

  def fill
    @food += Vendor::PivotalTracker.new(@user).serve
    @food += Vendor::Zendesk.new(@user).serve
    @food += Vendor::Github.new(@user).serve
  end
end
