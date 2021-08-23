class CommentSerializer < ActiveModel::Serializer
  attributes :id ,:post_id,:body,:author

  def author
    {
      id: object.user_id,
      name: User.find_by(id:object.user_id).name
    }
  end
end
