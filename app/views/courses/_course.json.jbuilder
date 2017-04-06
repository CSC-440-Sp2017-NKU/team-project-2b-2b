json.extract! course, :id, :prefix, :number, :title, :created_at, :updated_at
json.url course_url(course, format: :json)