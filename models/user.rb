class User
  @@stored_users = []
  attr_reader :id
  attr_reader :name
  attr_reader :pivotal_tracker_name
  attr_reader :zendesk_name
  attr_reader :zendesk_id
  attr_reader :github_login
  attr_reader :updated_at

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
    @zendesk_id = attrs.fetch(:zendesk_id, '').to_s
    @github_login = attrs.fetch(:github_login, nil)
    @updated_at = Time.now
  end

  def plate
    @plate = nil if @plate && (Time.now - @updated_at).to_i > 60 * 20
    return @plate unless @plate.nil?
    @plate = Plate.new(self)
    @plate.fill
    @updated_at = Time.now
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
