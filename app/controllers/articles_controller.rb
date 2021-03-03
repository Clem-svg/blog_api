class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_if_private, only: [:show ]
  before_action :check_if_author, only: [:update, :destroy]

  # GET /articles
  def index
    @articles = Article.all

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def check_if_private
      unless !@article.is_private || (current_user && current_user.id == @article.user.id)
        render json: {status: "error", code: 401, message: "This article is private"}
      end
    end

    def check_if_author
      unless current_user && current_user.id == @article.user.id
        render json: {status: "error", code: 401, message: "You can't modify this article"}
      end
    end
end