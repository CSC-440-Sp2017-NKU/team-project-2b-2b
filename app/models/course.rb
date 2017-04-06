class Course < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :questions, dependent: :destroy
end
