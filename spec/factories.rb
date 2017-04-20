FactoryGirl.define do
  factory :user do
    first_name "ALex"
    last_name "Dodge"
    email    "vasyutin243@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end