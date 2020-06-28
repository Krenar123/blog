class CommentsController < ApplicationController
    
    def new
        logged_in_notice unless logged_in?
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new
    end

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.build(comments_params)
        @comment.user = current_user
        if @comment.save
            redirect_to @article
        else
            render :new
        end
    end

    def edit 
        logged_in_notice unless logged_in?
        @comment = Comment.find(params[:id])
        logged_in_notice('danger','You have no permission',article_path(@comment.article)) unless equal_users?(@comment.user)
        @article = @comment.article
    end

    def update
        @article = Article.find(params[:article_id])
        @comment = Comment.find(params[:id])
        if @comment.update(comments_params)
            redirect_to article_path(@comment.article)
        else
            render :edit
        end
    end

    def destroy
        comment =  Comment.find(params[:id])
        if logged_in? && ( equal_users?(comment.user) || equal_users?(comment.article.user))
            comment.destroy
            redirect_to comment.article
        else
            logged_in_notice('danger','You have no permission',article_path(comment.article))
        end
    end

    private

    def comments_params
        params.require(:comment).permit(:body)
    end
end
