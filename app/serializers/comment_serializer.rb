class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :post_date
  has_one :commenter
end
