class Post < Granite::Base
  adapter pg
  table_name posts

  field title : String
  field preview : String
  field body : String
  field likes : Int32
  field category : String
  timestamps

  validate :title, "can't be blank" do |post|
    !post.title.to_s.blank?
  end

  validate :preview, "can't be blank" do |post|
    !post.preview.to_s.blank?
  end

  validate :body, "can't be blank" do |post|
    !post.body.to_s.blank?
  end
end