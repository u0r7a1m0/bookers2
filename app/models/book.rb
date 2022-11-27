class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  validates :title, :body, presence: true

end
