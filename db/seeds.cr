require "../config/application.cr"
require "faker"

93.times do |i|
  post = Post.new
  post.title = Faker::Lorem.sentence
  post.preview = Faker::Lorem.paragraph 5, true, 10
  post.body = post.preview.to_s + Faker::Lorem.paragraphs(10).join('\n')
  post.save
end
