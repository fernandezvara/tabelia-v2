class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  attr_accessible :email, :password, :password_confirmation, :avatar, :name, :about, :locale
  
  attr_accessor :password
  
  before_create :generate_username, :generate_token, :create_mailfolders
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
  
  # Avatar
  mount_uploader :avatar, AvatarUploader
  
  has_many :arts
  has_many :authorizations
  has_many :artcomments
  
  references_many :comments_received, :class_name => 'Comment', :foreign_key => 'receiver_id'
  references_many :comments_authored, :class_name => 'Comment', :foreign_key => 'author_id'
  
  
  def unreaded_conversations
    Userconversation.where(:user_id => self.id.to_s, :readed => false, :hide => false).count
  end
  
  def conversations
    Userconversation.where(:user_id => self.id, :hide => false)
  end
  
  def is_admin?
    # returns true if admin
    false unless self.admin == true
  end
  
  def self.authenticate(email, password)
  	user = User.where(:email => email).first
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  	  user
  	else
  	  nil
  	end
  end
  
  private
  
  # creates mail folders for the user on creation
  def create_mailfolders
    inbox = Mailfolder.create(:user => self, :type => 'i')
    outbox = Mailfolder.create(:user => self, :type => 'o')
    self.mailfolders << inbox
    self.mailfolders << outbox
    inbox.save
    outbox.save
  end
  
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
