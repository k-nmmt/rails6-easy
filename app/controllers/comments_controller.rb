class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.blog_id = params[:blog_id]

        if @comment.save
          flash[:notice] = "成功！"
          redirect_to("/blogs/#{params[blog_id]}")
        else
            @blog = Blog.find(params[:blog_id])
          flash.now[:alert] = "失敗！"
          render "blogs/show"
        end
      end
    
      private
        def comment_params
          params.require(:comment).permit(:body)
        end
end
