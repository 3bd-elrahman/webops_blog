class AddCommentToUser < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :comments , :users

  end
end
