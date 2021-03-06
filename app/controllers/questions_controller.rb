class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :unupvote, :undownvote, :solve, :unsolve]
  before_action :authenticate_user!
  before_action :require_same_user, only: [:edit, :destroy]
  # GET /questions
  # GET /questions.json

  def index
    @questions = Question.paginate(page: params[:page], per_page: 5).order('updated_at DESC')
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    current_user.likes @question
    redirect_to :back
    flash[:notice] = 'Question successfully upvoted'
  end

  def unupvote
    @question.unliked_by current_user
    redirect_to :back
    flash[:notice] = 'Upvote was successfully removed'
  end

  def downvote
    current_user.dislikes @question
    redirect_to :back
    flash[:danger] = 'Question successfully downvoted'
  end

  def undownvote
    @question.undisliked_by current_user
    redirect_to :back
    flash[:notice] = 'Downvote was successfully removed'
  end

  def solve
    @question.solved = 1
    @question.save
    redirect_to :back
    flash[:notice] = 'Question successfully marked as solved'
  end

  def unsolve
    @question.solved = 0
    @question.save
    redirect_to :back
    flash[:notice] = 'Question successfully marked as in progress'
  end

private

  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:title, :description, :course_id, :image)
  end

  def require_same_user
    if (current_user != @question.user) && (!current_user.admin?)
       redirect_to question_path(@question), notice: "You do not have access to modify this question"
    end
  end
end
