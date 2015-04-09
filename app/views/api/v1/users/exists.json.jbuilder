if @success
  json.success true
  json.exists @user.present?
else
  json.success false
end