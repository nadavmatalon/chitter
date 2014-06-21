require "sinatra"
require "data_mapper"
require "./lib/user.rb"
require "./lib/peep.rb"

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
DataMapper.finalize
DataMapper.auto_upgrade!
# DataMapper.auto_migrate!

set :views, Proc.new {File.join(root, '..', "views")}
set :public_folder, Proc.new {File.join(root, '..', "public")}

enable :sessions

set :session_secret, "information"


get "/" do
	session[:user_id] ||= nil
	erb :index
end

get "/sign_up" do
  erb :sign_up
end

get "/log_in" do
  erb :log_in
end
