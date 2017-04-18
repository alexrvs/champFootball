class User < ApplicationRecord
  user.url = auth_hash['info']['urls'][user.provider.capitalize]
end
