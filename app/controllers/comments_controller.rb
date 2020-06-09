class CommentsController < ApplicationController
    
    def new
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new
    end

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.build(comments_params)
        if @comment.save
            redirect_to article
        else
            render :new
        end
    end

    def edit 
        @comment = Comment.find(params[:id])
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
        comment.destroy
        redirect_to comment.article
    end

    private

    def comments_params
        params.require(:comment).permit(:commenter,:body)
    end
end
