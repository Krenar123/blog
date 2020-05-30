class CommentsController < ApplicationController
    
    def create
        article = Article.find(params[:article_id])
        article.comments.create(comments_params)
        redirect_to article
    end

    private

    def comments_params
        params.require(:comment).permit(:commenter,:body)
    end
end
