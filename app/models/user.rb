class User < ActiveRecord::Base

  has_many :sessions, foreign_key: :owner_id

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :username

  def add_session(datetime, duration)
    sessions.create start_at: datetime, end_at: datetime + duration
  end
end
