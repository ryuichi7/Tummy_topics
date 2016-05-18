class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :directions, :created_at, :image
  has_many :ratings
  has_many :comments
  has_one :user
end
