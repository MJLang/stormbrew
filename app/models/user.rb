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

class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true,
                    presence: true
  validates :password, presence: true

  validates :display_name, presence: true


  def update_login_count!
    self.last_login = DateTime.now.utc
    self.login_count += 1
    self.save
  end

  

end
