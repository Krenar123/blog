class ArticlesController < ApplicationController
  def index
    @title = 'I am going to buy that Tesla car.'
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
