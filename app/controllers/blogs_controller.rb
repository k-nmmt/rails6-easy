class BlogsController < ApplicationController
    def index
        @test = "ALL BLOGS"
      end

      def show
        @blog = Blog.find(params[:id])
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
    
      private
        def blog_params
          params.require(:blog).permit(:title, :body)
        end
end
