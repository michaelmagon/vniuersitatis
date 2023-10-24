class Group < ApplicationRecord

  mount_uploader :cover_image, ImageUploader
  has_many :group_users,  dependent: :destroy 
  has_many :users, :through => :group_users


end
