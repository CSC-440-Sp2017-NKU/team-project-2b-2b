class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :authorize_admin, only: [:new, :create, :destroy]

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.paginate(page: params[:page], per_page: 5).order('updated_at DESC')
    @answers = @user.answers.paginate(page: params[:page], per_page: 5).order('updated_at DESC')
    authorize current_user
  end

  def create
    @user = User.new(user_params)
    authorize @user  
  end
  
  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to root_path, :notice => "User updated."
    else
      redirect_to root_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to root_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:name, :email, :password, course_ids: [])
  end
  
  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
  
end
