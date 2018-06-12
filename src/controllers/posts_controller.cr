class PostsController < ApplicationController
  def index
    count = Post.count
    query_params = params.validation do
      optional(:page) { |p| !p.to_i?.nil? && (p.to_i - 1) * 5 < count }
      optional(:category) { |c| ["math", "programming", "outdoors", "other"].includes?(c) }
    end

    return redirect_to "/" unless query_params.valid?

    valid_params = query_params.validate!
    category = valid_params["category"]
    page = valid_params["page"].nil? ? 1 : valid_params["page"].to_s.to_i
    offset = (page.to_s.to_i - 1) * 5

    posts = category.nil? ? 
              Post.all("ORDER BY id DESC LIMIT 5 OFFSET ?", [offset]) : 
              Post.all("WHERE category = ? ORDER BY id DESC LIMIT 5 OFFSET ?", [category, offset])
    
    count = Post.all("WHERE category = ?", [category]).size unless category.nil?
    

    pages = Array(Int32 | Nil).new
    (page - 2..page + 2).each do |p|
      pages << (p <= 0 || (p - 1) * 5 >= count ? nil : p)
    end

    render "index.ecr"
  end

  def show
    if (params[:id].to_i?)
      post = Post.find(params[:id])
      return redirect_to "/posts" if post.nil?  
      render "show.ecr"
    else
      redirect_to "/posts"
    end
  end

  def new
    return redirect_to "/posts" unless session[:logged_in]
    render "new.ecr"
  end

  def create
    return redirect_to "/" unless session[:logged_in]

    post_params = params.validation do
      required(:title) { |p| !p.nil? && !p.empty? }
      required(:category) { |p| !p.nil? }
      required(:preview) { |p| !p.nil? && !p.empty? }
      required(:body) { |p| !p.nil? && !p.empty? }
    end

    unless post_params.valid?
      return redirect_back
    end

    post = Post.new post_params.validate!
    post.save

    redirect_to "/"
  end

  def edit
  end

  def update
  end

  def destroy
  end
end