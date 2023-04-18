class HomeController < ApplicationController
  def index
    @article = Article.first
  end
end
