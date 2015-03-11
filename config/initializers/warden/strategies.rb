Warden::Strategies.add(:password) do 
  def valid?
    params['email'] && params['password']
  end

  def authenticate!
    user = User.find_by_email(params['email'])
    if user && user.authenticate(params['password'])
      user.update_login_count!
      success!(user)
    else
      fail 'Invalid Email or Password'
    end
  end
end