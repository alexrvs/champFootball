class Avatar < ApplicationRecord
  mount_uploader :image, AvatarUploader

end