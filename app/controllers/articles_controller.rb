class ArticlesController < ApplicationController
  def index
    @title = 'I am going to buy that Tesla car.'
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.order(created_id: :desc)
    @comment = Comment.new
  end

  def new
    logged_in_notice unless logged_in?
    @article = Article.new
  end

  def edit
    if logged_in?
      @article = Article.find(params[:id])
      logged_in_notice('danger','You have no permission') unless equal_users?(@article.user)
    else
      logged_in_notice
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save 
      redirect_to @article
    else
      render :new
    end
  end

  def destroy
    article =  Article.find(params[:id])
    if equal_users?(article.user)
      article.destroy
      redirect_to articles_path
    else
      logged_in_notice('danger','You have no permission') 
    end
  end

  private
  
  def article_params
    params.require(:article).permit(:title,:body)
  end

end
