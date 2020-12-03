class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true, unless: :was_attached? do
    validates :title
    validates :target_site
    validates :content
  end

  def was_attached?
    self.image.attached?
  end
end
