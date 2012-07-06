class Session < ActiveRecord::Base
  attr_accessible :owner_id, :requester_id, :end_at, :start_at

  belongs_to :owner, class_name: "User"

  def duration
    end_at - start_at
  end
end
