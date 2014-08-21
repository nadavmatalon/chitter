require "sinatra"
require "data_mapper"
require "./lib/user.rb"
require "./lib/peep.rb"

env = ENV["RACK_ENV"] || "development"
# DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/chitter_#{env}")
DataMapper.finalize
DataMapper.auto_upgrade!
# DataMapper.auto_migrate!

set :views, Proc.new {File.join(root, '..', "views")}
set :public_folder, Proc.new {File.join(root, '..', "public")}

enable :sessions

set :session_secret, "information"


get "/" do
	session[:user_id] ||= nil	
	session[:user_id].nil? ? session[:welcome_message] = "Welcome Guest" : session[:welcome_message] = "Welcome #{current_user.username}"
	session[:user_message] = "Please sign-up or sign-in to post peeps" if session[:user_id].nil?
	@peeps = Peep.all
	erb :index
end

post "/sign-up" do
	session[:user_message] = nil
	erb :sign_up
end

post "/sign-in" do
	session[:user_message] = nil
	erb :log_in
end

post "/sign-out" do
	session[:user_id] = nil
	redirect "/"
end

post "/home" do
	session[:user_message] = ""
	redirect "/"
end

post "/new_user" do
	if (params[:password] != "") && (params[:password_confirmation] != "")
		@user = User.new(name: params[:name], username: params[:username],
						 email: params[:email], password: params[:password],
					 	password_confirmation: params[:password_confirmation])
		if @user.save
			session[:user_id] = @user.id
			redirect "/"
		else
			session[:user_message] = "Please try again"
			erb :sign_up
		end
	else
		session[:user_message] = "Please try again"
		erb :sign_up
	end
end

post "/login_user" do
	if (params[:email] != "") && (params[:password] != "")
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)
		if user
			session[:user_id] = user.id
			session[:user_message] = ""
			redirect "/"
		else
			session[:login_message] = "Please try again"
			erb :log_in
		end
	else
		session[:login_message] = "Please try again"
		erb :log_in
	end
end

post "/add_peep" do
	peep = Peep.new(content: params[:peep_content])
	current_user.peeps << peep
	if peep.save
		session[:user_message] = "Thanks #{current_user.username}, peep posted!"
		redirect "/"		
	else
		session[:user_message] = nil
		redirect "/"
	end
end

post "/log_out" do
	session[:user_id] = nil
	redirect "/"
end

post "/back" do
	redirect "/"
end

def current_user    
	@current_user ||= User.get(session[:user_id]) if session[:user_id]
end
