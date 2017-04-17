class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :last_activity]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @depts = []
    @depts = @courses.uniq.pluck(:prefix)
    @top_users = User.all.reject { |u| u.admin? }.sort_by(&:reputation).reverse[0..4]
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @questions = @course.questions.paginate(page: params[:questions_page], per_page: 5).order('updated_at DESC')
    @users = @course.users.paginate(page: params[:users_page], per_page: 5).order('name')
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:prefix, :number, :title)
    end
end
