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

require 'rails_helper'

RSpec.describe User, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
