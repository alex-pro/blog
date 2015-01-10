USERS_COUNT = 5
ARTICLES_COUNT = 3
COMMENTS_COUNT = 3
USER_PASSWORD = '123123'

USERS_COUNT.times do |user_index|
  user = User.create(email: "user#{user_index+1}@example.com", password: USER_PASSWORD, password_confirmation: USER_PASSWORD)

  ARTICLES_COUNT.times do |article_index|
    article = user.articles.create(title: "Title #{article_index+1}", description: "Text #{4-article_index}")

    COMMENTS_COUNT.times do |comment_index|
      article.comments.create(body: "Body #{comment_index+1}", user: user)
    end
  end
end
puts 'DONE!'
