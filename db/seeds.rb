# frozen_string_literal: true

user = User.create(email: 'email@email.com', password: 'password')

40.times do
  Post.create(title: Faker::Lorem.sentence(word_count: 6), user_id: user.id)
end
