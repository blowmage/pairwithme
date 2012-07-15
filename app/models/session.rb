class Session < ActiveRecord::Base
  attr_accessible :end_at, :start_at

  belongs_to :owner,     class_name: "User"
  belongs_to :requester, class_name: "User"

  validates :owner, presence: true

  def duration
    end_at - start_at
  end

  def available?
    !requester
  end

  def reserved?
    !available?
  end
end
