module CoursesHelper
  def last_activity(course)
    questions = course.questions
    combined = []
    combined += questions
    questions.each {|question| combined + question.answers}
    time_ago_in_words(combined.order('updated_at DESC').first.updated_at) + ' ago'
  end

  def user_count(dept_courses)
    count = 0
    dept_courses.each {|course| count += course.users.count}
    count
  end

  def question_count(dept_courses)
    count = 0
    dept_courses.each {|course| count += course.questions.count}
    count
  end

  def short_title(id)
    current_user.courses.select { |c| c.id == id }.each {|c| c.prefix + ' ' + c.number.to_s }
  end
end
