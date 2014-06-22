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
	session[:peep_message] = nil if session[:user_id] == nil
	@peeps = Peep.all
	erb :index
end

post "/sign_up" do
	session[:signup_message] = nil
	erb :sign_up
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
			session[:signup_message] = "Please try again"
			erb :sign_up
		end
	else
		session[:signup_message] = "Please try again"
		erb :sign_up
	end
end

post "/log_in" do
	session[:login_message] = nil
	erb :log_in
end


post "/login_user" do
	if (params[:email] != "") && (params[:password] != "")
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)
		if user
			session[:user_id] = user.id
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
	if peep.save
		current_user.peeps << peep
		current_user.save
		session[:peep_message] = "Thanks #{current_user.username}, peep uploaded!"
		redirect "/"
	else
		session[:peep_message] = nil
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
