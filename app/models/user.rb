require "email_validator"
require "reserved/usernames"

class User < ActiveRecord::Base

  has_many :sessions,     foreign_key: :owner_id
  has_many :reservations, foreign_key: :requester_id, class_name: "Session"

  has_many :authentications

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :username

  validates :email,    presence:   true,
                       uniqueness: true,
                       email:      true
  validates :username, presence:   true,
                       uniqueness: true,
                       length:     { in: 3..32 },
                       format:     { with: /^[a-z0-9_]+$/i,
                                     message: "can only have letters, numbers and '_'" },
                       exclusion:  { in: Reserved::USERNAMES,
                                     message: "is reserved" }
  validates :name,     presence:   true

  def self.find_by_username nick
    where("username LIKE ?", nick).first
  end

  def self.upcoming(limit = 12)
    Session.select(:start_at).select(:owner_id).includes(:owner).
            where("start_at > CURRENT_TIMESTAMP").
            where(requester_id: nil).order("MIN(start_at)").
            group(:start_at).group(:owner_id).limit(limit).map(&:owner)
  end

  def add_session(datetime, duration)
    sessions.create start_at: datetime, end_at: datetime + duration
  end

  def find_session(session_id)
    sessions.find(session_id)
  end

  def add_authentication provider, uid
    authentications.create(:provider => provider, :uid => uid)
  end

  def upcoming_sessions(limit = 10)
    self.sessions.where("start_at > CURRENT_TIMESTAMP").limit(limit)
  end

  def available_sessions(limit = 10)
    self.sessions.where("start_at > CURRENT_TIMESTAMP").where(requester_id: nil).limit(limit)
  end

  # def upcoming_reservatons
  #   self.sessions.where "start_at > CURRENT_TIMESTAMP"
  # end

  def can_reserve? session
    session.available? && session.owner != self
  end

  def reserve! session
    raise PairWithMe::CannotReserveSession unless can_reserve?(session)
    session.requester = self
    session.save!
    # TODO: The app may want to send emails
    # Create a UseCaseController to send emails and do extra work
  end
end
