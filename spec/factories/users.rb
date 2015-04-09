# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  email                 :string           not null
#  password_digest       :string
#  display_name          :string
#  login_count           :integer          default("0")
#  last_login            :datetime
#  password_reset_token  :string
#  reset_token_issued_at :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    display_name { FFaker::Internet.user_name }
    last_login nil
    login_count 0
    password_reset_token nil
    reset_token_issued_at nil
  end

end
