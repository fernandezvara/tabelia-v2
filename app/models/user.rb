class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Sunspot::Mongoid
  
  attr_accessible :email, :password, :password_confirmation, :avatar, :name, :about, :locale, :country_id
  
  attr_accessor :password
  
  before_create :generate_username, :generate_token, :generate_confirmation_tokens
  before_save :encrypt_password
  after_save     :resque_solr_update
  before_destroy :resque_solr_remove
  
  field :email,         :type => String
  field :password_hash, :type => String,   :presence => true
  field :password_salt, :type => String,   :presence => true
  field :avatar,        :type => String
  field :name,          :type => String,   :presence => true
  field :username,      :type => String,   :presence => true
  field :about,         :type => String
  field :auth_token,    :type => String,   :presence => true
  field :locale,        :type => String
  field :admin,         :type => Boolean,  :default => false
  field :show_search,   :type => Boolean,  :default => true
  field :conf1,         :type => String
  field :conf2,         :type => String
  field :confirmed,     :type => Boolean,  :default => false
  field :from_provider, :type => Boolean,  :default => false
  
  field :twitter_url,   :type => String
  field :facebook_url,  :type => String
  field :website_url,   :tyep => String
  
  belongs_to :country
  
  index :email,      unique: true
  index :auth_token, unique: true
  index :username,   unique: true
  index :conf1 # confirmation token 1
  index :conf2 # confirmation token 2
  
  validates_presence_of :name
  validates_presence_of :username
  validates_presence_of :email, :on => :update  
  validates_presence_of :country_id, :on => :update


  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :on => :update
                                  #    /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  
  # Avatar
  mount_uploader :avatar, AvatarUploader
  
  has_many :arts
  has_many :authorizations
  has_many :artcomments
  
  has_many :addresses
  
  has_many :orders
  
  references_many :comments_received, :class_name => 'Comment', :foreign_key => 'receiver_id'
  references_many :comments_authored, :class_name => 'Comment', :foreign_key => 'author_id'
  
  embeds_many :useractivities
  
  searchable do
    text :name, :boost => 3, :stored => true
    text :username
    integer :arts_count do
      self.arts.count
    end
    time :created_at
    boolean :show_search
  end
  
  def get_data_from_provider(auth)
    # auth = hash with data from provider
    self.from_provider = true
    self.email = auth["info"]["email"] if auth["info"]["email"]
    self.name = auth["info"]["name"] if auth["info"]["name"]
    
    if auth["info"]["nickname"]
      self.username = auth["info"]["nickname"]
    else
      if self.name
        self.username = self.name.parameterize
      else
        self.username = ""
      end
    end
    
    if auth["info"]["urls"]
      self.website_url = auth["info"]["urls"]["Website"] if auth["info"]["urls"]["Website"]
      case auth["provider"]
      when "twitter1"
        self.twitter_url = auth["info"]["urls"]["Twitter"] if auth["info"]["urls"]["Twitter"]
      when "facebook"
        self.facebook_url = auth["info"]["urls"]["Facebook"] if auth["info"]["urls"]["Facebook"]
      end
    end
        
    # fake password
    random_password = ActiveSupport::SecureRandom.hex(10)
    self.password = random_password
    self.password_confirmation = self.password
    
    puts self.inspect
  end
  
  
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
  
  def encrypt_password
  	if password.present?
  	  self.password_salt = BCrypt::Engine.generate_salt
  	  self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end
  
  def generate_confirmation_tokens
    self.conf1 = SecureRandom.urlsafe_base64
    self.conf2 = SecureRandom.urlsafe_base64
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
  
  protected
  
  def resque_solr_update
    Resque.enqueue(SolrUpdate, "User", id)
  end

  def resque_solr_remove
    Resque.enqueue(SolrRemove, "User", id)
  end
  
end
