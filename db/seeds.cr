require "../config/application.cr"
require "Faker"

categories = ["math", "programming", "outdoors", "other"]

93.times do |i|
  post = Post.new
  post.title = Faker::Lorem.sentence
  post.preview = Faker::Lorem.paragraph 5, true, 10
  post.body = post.preview.to_s + Faker::Lorem.paragraphs(10).join('\n')
  post.category = categories.sample
  post.save
end
