class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :thumb 

  def thumb
  	object.avatar.url(:thumb)
  end
end
