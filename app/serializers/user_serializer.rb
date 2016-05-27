class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :thumb, :email_name

  def thumb
  	object.avatar.url(:thumb)
  end

end
	