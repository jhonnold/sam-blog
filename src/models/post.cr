class Post < Granite::Base
  adapter pg
  table_name posts

  primary id : Int64
  field title : String
  field preview : String
  field body : String
  field likes : Int32
  field category : Int32
  timestamps

  validate :title, "can't be blank" do |post|
    !post.title.to_s.blank?
  end

  validate :body, "can't be blank" do |post|
    !post.body.to_s.blank?
  end
end
