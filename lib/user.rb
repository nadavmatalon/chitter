require "data_mapper"
require "bcrypt"

class User

	include DataMapper::Resource
	
	has n, :peeps

	property :id, Serial
	property :name, String, required: true
	property :username, String, unique: true, required: true
	property :email, String, unique: true, required: true
	property :password_digest, Text, required: true

	attr_reader :password
	attr_accessor :password_confirmation

	validates_uniqueness_of :username
	validates_uniqueness_of :email

	validates_confirmation_of :password

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(email: email)
		(user && BCrypt::Password.new(user.password_digest) == password) ? user : nil	
	end
end

