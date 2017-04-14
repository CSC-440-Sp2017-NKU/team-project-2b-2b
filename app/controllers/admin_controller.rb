class AdminController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :authorize_admin, only: [:index]

  def index
    @users = User.all
    @courses = Course.all
    authorize User
  end

  private
  def authorize_admin
    redirect_to courses_path unless current_user.admin?
  end

end
