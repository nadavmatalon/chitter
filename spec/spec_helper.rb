ENV["RACK_ENV"] = "test"

require "./app/server.rb"
require "database_cleaner"
require "capybara/rspec"
require 'capybara/poltergeist'
require "debugger"
require "launchy"
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','*.rb'))].each {|f| require f}


Capybara.app = Sinatra::Application.new

Capybara.default_driver = :poltergeist

Capybara.ignore_hidden_elements = false

Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {debug: false, js_errors: false, phantomjs_options: ['--load-images=no']})
end

Capybara.server do |app, port|
	require 'rack/handler/thin'
	Rack::Handler::Thin.run(app, Port: port)
end


RSpec.configure do |config|

	config.treat_symbols_as_metadata_keys_with_true_values = true
	# config.run_all_when_everything_filtered = true
	# config.filter_run :focus

	# config.order = "random"

	config.include Capybara::DSL, type: :feature

	config.before(:suite) do
		DatabaseCleaner.strategy = :transaction
		DatabaseCleaner.clean_with(:truncation)
	end

	config.before(:each, js: true) do
    	DatabaseCleaner.strategy = :truncation
  	end

	config.before(:each) do
		DatabaseCleaner.start
	end

	config.after(:each) do
		DatabaseCleaner.clean
	end
end
