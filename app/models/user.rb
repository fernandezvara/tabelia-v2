class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  attr_accessible :email, :password, :password_confirmation, :avatar, :name, :about, :locale
  
  attr_accessor :password
  
  before_create :generate_username, :generate_token
  before_save :encrypt_password
  
  field :email,         :type => String, :presence => true
  field :password_hash, :type => String, :presence => true
  field :password_salt, :type => String, :presence => true
  field :avatar,        :type => String
  field :name,          :type => String, :presence => true
  field :username,      :type => String, :presence => true
  field :about,         :type => String
  field :auth_token,    :type => String, :presence => true
  field :locale,        :type => String
  
  index :email, unique: true
  index :auth_token, unique:true
  index :username, unique:true
  
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
                                  #    /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  has_many :arts
  
  def self.authenticate(email, password)
  	user = User.where(:email => email).first
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  	  user
  	else
  	  nil
  	end
  end
  
  private
  
  def encrypt_password
  	if password.present?
  	  self.password_salt = BCrypt::Engine.generate_salt
  	  self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end
  
  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.where(:auth_token => self.auth_token).count > 0
  end
  
  # @generate_username
  # generates a username based on the name 
  # so 'Antonio Fernandez' became 'antonio-fernandez' unless there is already that username that makes 'antonio-fernandez-1' and so on
  def generate_username(text = nil, counter = 0)
    if text.nil?
      text = name
      temp_username = name.parameterize
    else
      counter +=1
      temp_username = "#{text}-#{counter}".parameterize
    end
    
    u = User.where(:username => temp_username).count
    if u == 0
      self.username = temp_username
    else
      generate_username(text, counter)
    end
  end
  
end
