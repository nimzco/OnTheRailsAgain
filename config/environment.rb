# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OntheRailsAgain::Application.initialize!
Encoding.default_internal, Encoding.default_external = ['utf-8'] * 2
