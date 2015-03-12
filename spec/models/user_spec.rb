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

require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'Helper Methods' do
    let(:user) {FactoryGirl.create(:user)}
    it '#update_login_count!' do
      user.update_login_count!
      expect(user.login_count).to eq(1)
    end
  end
end
