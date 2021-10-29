class BlogsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]


    def index
        @test = "ブログ一覧"
        @blog = Blog.all
      end

      def show
        @blog = Blog.find(params[:id])
        @comment = Comment.new
      end

      def new
        @blog = Blog.new
      end

      def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
        if @blog.save
           flash[:notice] = "成功！"
           redirect_to("/blogs/#{@blog.id}")
        else
           flash.now[:alert] = "失敗！"
           render("blogs/new")
        end
      end
      
  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      flash[:notice] = "成功！"
      redirect_to("/blogs/#{@blog.id}")
    else
      flash.now[:alert] = "失敗！"
      render("blogs/edit")
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    flash[:notice] = "成功！"
    redirect_to("/blogs")
  end

    
      private
        def blog_params
          params.require(:blog).permit(:title, :body)
        end

        def ensure_correct_user
          @blog = Blog.find_by(id: params[:id])
          if @blog.user_id != current_user.id
            flash[:alert] = "権限がありません"
            redirect_to("/blogs/#{@blog.id}")
          end
        end
end
