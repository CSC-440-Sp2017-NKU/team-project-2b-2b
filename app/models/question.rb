class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  belongs_to :course
  acts_as_votable
end
