class PostsController < ApplicationController
  def index
    count = Post.count
    query_params = params.validation do
      optional(:page) { |p| !p.to_i?.nil? && (p.to_i - 1) * 5 < count }
    end

    return redirect_to "/posts" unless query_params.valid?

    valid_params = query_params.validate!
    
    page = valid_params.has_key?("page") ? valid_params["page"].to_s.to_i : 1
    offset = (page.to_s.to_i - 1) * 5

    posts = Post.all("ORDER BY id DESC LIMIT 5 OFFSET ?", [offset])
    count = Post.all().size

    pages = Array(Int32 | Nil).new
    (page - 2..page + 2).each do |p|
      pages << (p <= 0 || (p - 1) * 5 >= count ? nil : p)
    end

    logged_in = session[:logged_in]

    render "index.ecr"
  end

  def show
    logged_in = session[:logged_in]
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
      required(:preview) { |p| !p.nil? && !p.empty? }
      required(:body) { |p| !p.nil? && !p.empty? }
    end

    unless post_params.valid?
      return redirect_back
    end

    post = Post.new post_params.validate!
    post.save

    redirect_to "/posts"
  end

  def edit
    return redirect_back unless params[:id].to_i? && session[:logged_in]

    post = Post.find(params[:id])
    return redirect_back if post.nil?
    
    render "edit.ecr"
  end

  def update
  end

  def destroy
    return redirect_back unless session[:logged_in]
    if (params[:id].to_i?)
      post = Post.find(params[:id])
      post.destroy unless post.nil?
    end
    return :index
  end

  def home
    redirect_to "/posts"
  end
end
