class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :body_weights, dependent: :destroy
  has_many :bench_press_weight_records, dependent: :destroy
  has_many :dead_lift_weight_records, dependent: :destroy

  validates :nickname, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
