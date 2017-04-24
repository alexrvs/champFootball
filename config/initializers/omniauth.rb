Rails.application.config.middleware.use OmniAuth::Builder do
   provider :facebook, "1773942389583387", "8785188a22f52c498f95abe9862bf2f8",
            scope: 'email,user_birthday,public_profile',
            info_fields: 'first_name,last_name,gender,birthday,email'
end
