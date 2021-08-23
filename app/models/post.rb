class Post < ApplicationRecord
    paginates_per 2
    belongs_to :user , class_name:'User' ,foreign_key:'user_id'
    has_many :comments , class_name:"Comment",foreign_key:'post_id',:dependent => :destroy
    has_and_belongs_to_many :tags ,through: :tag_names
end
