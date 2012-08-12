class Food::Zendesk < Food
  def initialize(attrs)
    @category = "Zendesk Tickets"
    @type = "zendesk_ticket"
    super(attrs)
  end
end
