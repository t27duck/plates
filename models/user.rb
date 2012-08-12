class User
  @@stored_users = []
  attr_reader :id
  attr_reader :name
  attr_reader :pivotal_tracker_name
  attr_reader :zendesk_name
  attr_reader :github_login

  def self.all
    return @@stored_users unless @@stored_users.empty?
    YAML.load_file("config/users.yml")["users"].each do |u|
      @@stored_users <<  User.new(u.symbolize_keys)
    end
    @@stored_users
  end

  def self.find(id)
    all.detect{|u| u.id == id}
  end

  def initialize(attrs={})
    @id = attrs.fetch(:id, next_id)
    @name = attrs.fetch(:name)
    @pivotal_tracker_name = attrs.fetch(:pivotal_tracker_name, nil)
    @zendesk_name = attrs.fetch(:zendesk_name, nil)
    @github_login = attrs.fetch(:github_login, nil)
  end

  def plate
    return @plate unless @plate.nil?
    @plate = Plate.new(self)
    @plate.fill
    @plate
  end

  def clear_plate!
    @plate = nil
  end

  private ######################################################################

  def next_id
    (@@stored_users.size + 1).to_s
  end

end
