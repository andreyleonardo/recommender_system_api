User.delete_all

puts 'Creating users'
start = Time.zone.now
# generate random users
(1..668).each do |user_id|
  User.create(
    id: user_id,
    email: "andrey_#{user_id}@anything.com",
    password: '12345678',
    password_confirmation: '12345678'
  )
end
puts Time.zone.now - start
