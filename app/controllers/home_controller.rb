class HomeController < ApplicationController
  def index
    @upcoming = User.upcoming
  end
end
