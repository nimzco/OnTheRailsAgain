require 'factory_girl'

Factory.define :author do |author|
  author.name                   "Test User"
  author.email                  "user@example.com"
  author.password               "password"
  author.password_confirmation  "password"
end