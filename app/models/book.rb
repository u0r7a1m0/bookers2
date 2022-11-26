class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :userend
  validates :title, :body, presence: true

end
