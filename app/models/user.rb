class User < ActiveRecord::Base
  # Include default devise modules.
  
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :project
  belongs_to :role
  belongs_to :department
  has_many :calendars

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: /\A\w+@\w+\.[a-z]+\z/ }
  #validates_presence_of :password, :on => :create
  validates_length_of :email, :within => 8..30
  validates_length_of :password, :within => 8..30
  #validates_uniqueness_of :email, :case_sensitive => false, format: { with: /\A\w+@\w+\.[a-z]+\z/ }
  
  #has_secure_password

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
