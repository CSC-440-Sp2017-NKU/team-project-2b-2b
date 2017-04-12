class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  belongs_to :course
  acts_as_votable
  has_attached_file :image, styles: { thumb: ["64x64#", :jpg], original: ['500x500>', :jpg] },
                    convert_options: {thumb: '-quality 75 -strip', original: "-quality 85 -strip" }
  validates_attachment :image,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png","image/pdf"] }
end
