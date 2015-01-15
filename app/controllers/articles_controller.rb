class ArticlesController < ApplicationController
  before_filter :article, only: [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @search = Article.search do
      fulltext params[:search]
      order_by sort_column, sort_direction
      paginate :page => params[:page], :per_page => 5
    end
    @articles = @search.results
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def article
    redirect_to articles_path unless @article = current_user.articles.find_by_id(params[:id])
  end

  def sort_column
    Article.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
