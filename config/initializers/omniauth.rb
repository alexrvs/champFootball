Rails.application.config.middleware.use OmniAuth::Builder do
   provider :facebook, "1773942389583387", "8785188a22f52c498f95abe9862bf2f8",
            scope: email,
            client_options: {
                site: 'https://graph.facebook.com/v3.0',
                authorize_url: "https://www.facebook.com/v3.0/dialog/oauth"
            }
end
