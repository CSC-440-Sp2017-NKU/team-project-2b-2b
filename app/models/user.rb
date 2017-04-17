class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :courses
  acts_as_voter

  def set_default_role
    self.role ||= :user
  end

  def reputation
    rep = 0
    questions.each { |q| rep += (q.get_upvotes.size * 30) - (q.get_downvotes.size * 20) }
    answers.each { |a| rep += (a.get_upvotes.size * 30) - (a.get_downvotes.size * 20) }
    rep += questions.count * 10 + answers.count * 15 + sign_in_count * 5
    rep
  end

  def first_name
    name.split(' ')[0]
  end

  def last_name
    name.split(' ')[1]
  end

  def email_prefix
    email.split('@')[0]
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
