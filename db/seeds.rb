# frozen_string_literal: true

user = User.create(email: 'email@email.com', password: 'password')

Tag.create(name: 'rails')
Tag.create(name: 'javascript')
Tag.create(name: 'css')

80.times do
  post = Post.create(title: Faker::Lorem.sentence(word_count: 6), user_id: user.id)
  Tagging.create(post_id: post.id, tag_id: Tag.all.sample.id)
end
