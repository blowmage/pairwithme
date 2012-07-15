class User < ActiveRecord::Base

  has_many :sessions,     foreign_key: :owner_id
  has_many :reservations, foreign_key: :requester_id, class_name: "Session"

  has_many :accounts

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :username

  validates :email, :username, presence:       true,
                               uniqueness:     true
  validates :name,             presence:       true

  def add_session(datetime, duration)
    sessions.create start_at: datetime, end_at: datetime + duration
  end

  def add_account provider, uid
    accounts.create(:provider => provider, :uid => uid)
  end

  def upcoming_sessions
    self.sessions.where "start_at > CURRENT_TIMESTAMP"
  end

  def available_sessions
    self.sessions.where("start_at > CURRENT_TIMESTAMP").where(requester_id: nil)
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
