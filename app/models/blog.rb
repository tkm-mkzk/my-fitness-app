class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :target_site
    validates :content
  end
end
