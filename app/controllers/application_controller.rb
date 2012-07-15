class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_time_zone

  protected

  def set_time_zone
    Time.zone = "America/Boise"
  end
end
