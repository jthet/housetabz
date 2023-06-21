Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000' # Add the URL of your client application

    resource '*', headers: :any, methods: [:get, :post, :options]
  end
end
