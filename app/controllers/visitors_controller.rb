class VisitorsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @questions = Question.paginate(page: params[:page], per_page: 5).order('updated_at DESC')
  end
end
