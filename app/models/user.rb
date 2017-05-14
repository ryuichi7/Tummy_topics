class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes, dependent: :destroy
  has_many :comments, foreign_key: :commenter_id, dependent: :destroy
  has_many :reviews, through: :recipes, source: "comments", dependent: :destroy
  has_many :received_ratings, through: :recipes, source: "ratings", dependent: :destroy
  has_many :ratings, foreign_key: :rater_id, dependent: :destroy

  has_attached_file :avatar, default_url: ':style/placeholder_image.png', styles: { thumb: "36x36#", original: "200x200#" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  include Concerns::Dateable

  def email_name
  	email.split("@").first.humanize
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end      
  end

end
