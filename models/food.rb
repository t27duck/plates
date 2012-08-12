class Food
  attr_reader :title
  attr_reader :state
  attr_reader :remote_id
  attr_reader :category
  attr_reader :type
  attr_reader :description
  attr_reader :misc_info
  attr_reader :url
  attr_reader :created_at
  attr_reader :updated_at

  def initialize(attrs)
    @title        = attrs.fetch(:title)
    @state        = attrs.fetch(:state)
    @remote_id    = attrs.fetch(:remote_id)
    @url          = attrs.fetch(:url)
    @description  = attrs.fetch(:description, "")
    @misc_info    = attrs.fetch(:misc_info, {})
    @created_at   = attrs.fetch(:created_at, nil)
    @updated_at   = attrs.fetch(:updated_at, nil)
  end
end
