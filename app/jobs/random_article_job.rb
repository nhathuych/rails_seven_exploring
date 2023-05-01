class RandomArticleJob < ApplicationJob
  queue_as :ramdom_article

  def perform(article_num)
    puts("----------- JOB RANDOM WITH #{article_num} ARTICLES.")

    Article.delete_all
    (1..article_num).each do |num|
      Article.create(title: Faker::Movie.title, content: Faker::Movie.quote)
      sleep(1)
    end
  end
end
