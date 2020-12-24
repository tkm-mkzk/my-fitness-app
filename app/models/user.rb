class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :current_password

  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :body_weights, dependent: :destroy
  has_many :bench_press_weight_records, dependent: :destroy
  has_many :dead_lift_weight_records, dependent: :destroy
  has_many :squat_weight_records, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'is invalid. Password Include both letters and numbers' }, on: :create

  def self.guest
    find_or_create_by!(nickname: 'guest', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
