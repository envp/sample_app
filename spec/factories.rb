FactoryGirl.define do
  # Factory for UserModel
  factory :user do
    name                   'Example User'
    email                  'user@example.com'
    password               'foobar'
    password_confirmation  'foobar'
  end
end
