# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  email                 :string
#  password_digest       :string
#  display_name          :string
#  last_login            :datetime
#  password_reset_token  :string
#  reset_token_issued_at :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    display_name { Faker::Internet.user_name }
    last_login nil
    password_reset_token nil
    reset_token_issued_at nil
  end

end
