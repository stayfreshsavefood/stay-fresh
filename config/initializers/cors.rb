Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://shelf-life-api.herokuapp.com'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end
