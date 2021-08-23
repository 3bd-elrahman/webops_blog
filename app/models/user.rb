class User < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64

  include Rails.application.routes.url_helpers
  
  has_one_base64_attached :image

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates_confirmation_of :password
  has_many :posts ,class_name:'Post',foreign_key:'user_id'
  has_many :comments ,class_name:'Comment',foreign_key:'user_id'
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :validatable,
         jwt_revocation_strategy: JwtDenylist

  def get_image_url
     url_for(self.image)
  end
end

