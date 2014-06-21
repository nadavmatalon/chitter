require "data_mapper"
require "bcrypt"

class User

	include DataMapper::Resource
	
	has n, :peeps, through: Resource

	property :id, Serial
	property :name, String, required: true, message: "User name cannot be empty"
	property :username, String, unique: true, required: true, message: "This user name is already taken"
	property :email, String, unique: true, required: true, message: "This email is already taken"
	property :password_digest, Text, required: true

	attr_reader :password
	attr_accessor :password_confirmation

	validates_uniqueness_of :username  #not needed when using data_mapper
	validates_uniqueness_of :email  #not needed when using data_mapper

	validates_confirmation_of :password
	# validates_confirmation_of :password, :message => "Sorry, your passwords don't match"

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(email: email)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

end

