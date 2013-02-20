class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :confirmed_at, :confirmation_sent_at, :uid, :first_name, :last_name
  attr_accessor :login

  has_many :rsvps
  has_many :events, :through => :rsvps

  has_attached_file :avatar, :styles => {:thumb => "150x115"}

  @login_regex = /[a-z0-9_-]{3,15}/
  @email_regex = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  validates :username, :format => {:with => @login_regex, :message => "You can use only letters, numbers, _ and - symbols"}
  validates_presence_of :email
  validates_format_of :email, :with => @email_regex

  has_many :parts
  has_many :part_types, :through => :parts

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    else
      where(conditions).first
    end
  end

  def is_admin?
    current_user.email == "faraon.ua@gmail.com"
  end
end
