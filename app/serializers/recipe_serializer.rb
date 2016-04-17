class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :directions, :created_at
  has_many :ratings
  has_many :comments
  has_one :user
end
