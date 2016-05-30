source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.3.11'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Ruby implementation of the RFC 7519 OAuth JSON Web Token standard
gem 'jwt', '~> 1.5.4'
# Simple, standardized way to build and use Service Objects (aka Commands)
gem 'simple_command', '~> 0.0.9'
# Convention over configuration for JSON generation
gem 'active_model_serializers', '~> 0.10.0'
# Set of helpers for simple, robust and scaleable authorization systems
gem 'pundit', '~> 1.1.0'
# Handle Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Rack middleware for blocking & throttling abusive requests
gem 'rack-attack'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0.5', platform: :mri
end

group :development do
  # Listens to file changes and notifies you about the changes
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background
  gem 'spring', '~> 1.7.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Mock Time.now, Date.today, and DateTime.now in a single call
  gem 'timecop', '~> 0.8.1'
end
