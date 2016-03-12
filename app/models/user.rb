class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
  has_many :comments, foreign_key: :commenter_id
  has_many :reviews, through: :recipes, source: "comments"
  has_many :received_ratings, through: :recipes, source: "ratings"
  has_many :ratings, foreign_key: :rater_id
end
