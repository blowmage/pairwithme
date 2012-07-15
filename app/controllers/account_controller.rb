class AccountController < ApplicationController
  before_filter :authenticate_user!, only: :reserve
  before_filter :resolve_account

  def index
  end

  def reserve
    @session = @account.find_session(params[:id])
    redirect_to :index if @session.nil?

    current_user.reserve! @session
  end

  protected

  def resolve_account
    @account = User.find_by_username(params[:username])
    # TODO: Display fancy "This will be mine!" page like rubygems.org?
    redirect_to root_path unless @account
  end
end
