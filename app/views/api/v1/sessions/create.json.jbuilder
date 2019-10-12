json.user do |json|
  json.partial! 'api/v1/users/user', user: current_user
end
