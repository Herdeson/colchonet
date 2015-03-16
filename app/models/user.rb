class User < ActiveRecord::Base
	EMAIL_REGEXP =  /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	#validates_presence_of :email, :full_name, :location, :password
	#validates_confirmation_of :password
	validates_presence_of :email, :full_name, :location
	validates_length_of :bio, minimum: 30, allow_blank: false
	validates_uniqueness_of :email

	scope :confirmed, -> { where.not(confirmed_at: nil)}

	validate :email_format

	has_secure_password


	def self.authenticate(email, password)
		user = confirmed.find_by(email: email).
							try(:authenticate, password)

	end


	private
	# Validação poderia ser representada da seguinte forma:
	# validates_format_of :email, with: EMAIL_REGEXP
	def email_format
		errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
			
	end


end
