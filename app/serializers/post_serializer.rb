class PostSerializer < ActiveModel::Serializer
  attributes :id  , :author ,:title ,:body,:tags

  def author
    author_name = User.find_by(id:object.user_id).name
  end
end
