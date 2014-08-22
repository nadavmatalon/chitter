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
	session[:selector] ||= "date"
	session[:user_id].nil? ? session[:welcome_message] = "Welcome Guest" : session[:welcome_message] = "Welcome #{current_user.username}"
	session[:user_message] = "Please sign-up or sign-in to post peeps" if session[:user_id].nil?
	@peeps = []
	Peep.all.map do |peep|
		author = User.select{ |user| user.peeps.include?(peep) }.first.username
		@peeps << { id: -peep.id, author: author, time: peep.time, content: peep.content }
	end
	session[:selector] == "date" ? @peeps.reverse! : @peeps.sort_by! {|peep| [peep[:author], peep[:id]] }
	erb :index
end

post "/peep-selector" do
	session[:selector] = params[:selector].downcase
	redirect "/"
end

post "/home" do
	session[:user_message] = ""
	redirect "/"
end

post "/sign-up" do
	session[:user_message] = nil
	erb :sign_up
end

post "/sign-in" do
	session[:user_message] = nil
	erb :sign_in
end

post "/sign-out" do
	session[:user_id] = nil
	session[:selector] = "date"
	redirect "/"
end

post "/sign-up-user" do
	if (params[:password] != "") && (params[:password_confirmation] != "")
		@user = User.new(name: params[:name], username: params[:username],
						 email: params[:email], password: params[:password],
					 	password_confirmation: params[:password_confirmation])
		if @user.save
			session[:user_id] = @user.id
			session[:user_message] = ""
			redirect "/"
		else
			session[:user_message] = "Sorry, please try again"
			erb :sign_up
		end
	else
		session[:user_message] = "Sorry, please try again"
		erb :sign_up
	end
end

post "/sign-in-user" do
	if (params[:email] != "") && (params[:password] != "")
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)
		if user
			session[:user_id] = user.id
			session[:user_message] = ""
			redirect "/"
		else
			session[:user_message] = "Sorry, please try again"
			erb :sign_in
		end
	else
		session[:user_message] = "Sorry, please try again"
		erb :sign_in
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

private

def current_user    
	@current_user ||= User.get(session[:user_id]) if session[:user_id]
end
