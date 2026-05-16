# Be sure to restart your server when you modify this file.
# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(
      if Rails.env.development?
        %w[
          http://localhost:5173
          http://127.0.0.1:5173
          http://localhost:5174
          http://127.0.0.1:5174
        ]
      else
        ENV.fetch("CORS_ORIGINS", "").split(",").map(&:strip).reject(&:blank?)
      end
    )

    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[Authorization],
      max_age: 600
  end
end
