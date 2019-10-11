5.times { p 'ello' }
json.user do |json|
  json.partial! 'users/user', user: current_user
end
