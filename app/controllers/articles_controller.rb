class ArticlesController < ApplicationController
  def index
    @articles = Article.limit(10)

    if params[:ramdom].present?
      RandomArticleJob.perform_later(10)
      redirect_to root_path
    end
  end
end
