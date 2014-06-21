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

post "/sign_up" do
	session[:signup_message] = nil
	erb :sign_up
end

post "/new_user" do
	@user = User.new(name: params[:name], username: params[:username],
					 email: params[:email], password: params[:password],
					 password_confirmation: params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to("/")
	else
		session[:signup_message] = "Please try again"
		erb :sign_up
	end

end

post "/log_in" do
	erb :log_in
end

post "/log_out" do
	session[:user_id] = nil
	redirect "/"
end
