class Vendor::Zendesk < Vendor

  def serve
    food = []
    view_data.each do |row|
      next if row["assignee"].to_s != user.zendesk_id
      food << create_food(row.deep_symbolize_keys)
    end
    food
  end

  private ######################################################################

  def food_class
    Food::Zendesk
  end

  def view_data
    url = "https://#{CONFIG[:zendesk][:subdomain]}.zendesk.com/api/v2/views/#{CONFIG[:zendesk][:view_id]}/execute.json"
    response = Curl.get(url) do |curl|
      curl.headers['Content-Type'] = "application/json"
      curl.username = CONFIG[:zendesk][:username]
      curl.password = CONFIG[:zendesk][:password]
      curl.timeout = 10 # Seconds
    end
    JSON.parse(response.body_str)["rows"]
  end

  def food_fields(row)
    {
      :title => row[:subject],
      :state => row[:status] || "Open",
      :description => row[:ticket] ? row[:ticket][:description] : "",
      :misc_info => {
        :requester => requester_name(row),
        :priority => row[:priority]
      },
      :created_at => (Date.parse(row[:created]) rescue nil),
      :url => row[:url] || "https://#{CONFIG[:zendesk][:subdomain]}.zendesk.com/tickets/#{row[:ticket][:id]}",
      :remote_id => row[:remote_id] || row[:ticket][:id]
    }
  end

  def requester_name(row)
    return row[:requester][:name] if row[:requester]
    "UNKNOWN"
  end
end
