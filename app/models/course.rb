class Course < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :questions, dependent: :destroy

  def full_title
    prefix + ' ' + number.to_s + ' - ' + title
  end

  def short_title
    prefix + ' ' + number.to_s
  end

end
