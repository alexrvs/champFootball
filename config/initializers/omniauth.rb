Rails.application.config.middleware.use OmniAuth::Builder do
   provider :facebook, ENV['app_id'], ENV['secret'],
            scope: 'email,user_birthday,public_profile',
            info_fields: 'first_name,last_name,gender,birthday,email'
end
