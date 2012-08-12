class Vendor
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  private ######################################################################
  
  def create_food(data)
    food_class.new(food_fields(data))
  end

end
