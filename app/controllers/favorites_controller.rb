class FavoritesController < ApplicationController
  before_action :set_article
  
  def create
    favorite = current_user.favorites.new(favorited: @article)
    if favorite.save
      redirect_to @article, notice: 'Artikel opgeslagen in favorieten'
    else
      redirect_to @article, alert: 'Er is iets misgegaan.'
    end
  end
  
  def destroy
    favorite = current_user.favorites.find_by(favorited: @article)
    if favorite.destroy
      redirect_to @article, notice: 'Artikel is verwijderd uit favorieten'
    else
      redirect_to @article, notice: 'Er is iets misgegaan.'
    end
  end
  
  private
  
  def set_article
    @article = Article.find(params[:article_id])
  end
end
