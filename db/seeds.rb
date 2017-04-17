# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email

# Bulk add courses
csv_text = File.read(Rails.root.join('lib', 'seeds', 'courses.csv')).strip
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')

dept_csv_text = File.read(Rails.root.join('lib', 'seeds', 'departments.csv')).strip
dept_csv = CSV.parse(dept_csv_text, headers: true, encoding: 'UTF-8')

depts = {}
dept_csv.each do |row|
  depts[row[0]] = row[1]
end

csv.each do |row|
  Course.create(prefix: row[0], number: row[1], title: row[2], dept: depts[row[0]] )
end

puts "There are now #{Course.count} rows in the courses table"

# Bulk add students
csv_text = File.read(Rails.root.join('lib', 'seeds', 'students.csv')).strip
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
csv.each do |row|
  courses = []
  (3..8).each do |i|
    if row[i]
      course = row[i].split(' ')
      courses << Course.where(prefix: course[0], number: course[1])
    end
  end
  user = User.create(name: row[0], email: row[1] + '@nku.edu', password: row[2])
  courses.each { |c| user.courses.push(c) }
  user.save
end

puts "There are now #{User.count} rows in the users table"
