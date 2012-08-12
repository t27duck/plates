class Hash
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end

  def deep_symbolize_keys
    result = {}
    each do |key, value|
      result[(key.to_sym rescue key)] = value.is_a?(Hash) ? value.deep_symbolize_keys : value
    end
    result
  end
end
