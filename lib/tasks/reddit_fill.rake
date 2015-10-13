desc 'Creates users for all posts'
task :make_users_from_posts => :environment do
  Post.all.each do |post|
    email = post.creator_name + "@tidder.com"
    password = SecureRandom.urlsafe_base64
    nickname = post.creator_name

    user = User.find_or_create_by(nickname: nickname) do |user_foc|
      user_foc.email = email
      user_foc.password = password
      user_foc.password_confirmation = password
    end
    Post.where(creator_name: user.nickname).each do |post_add_user_id|
      post_add_user_id.user_id = user.id
      post_add_user_id.save
    end
  end
end

desc 'Creates users for all comments'
task :make_users_from_comments => :environment do
  Comment.all.each do |comment|
    email = comment.author_name + "@tidder.com"
    password = SecureRandom.urlsafe_base64
    nickname = comment.author_name

    user = User.find_or_create_by(nickname: nickname) do |user_foc|
      user_foc.email = email
      user_foc.password = password
      user_foc.password_confirmation = password
    end
    Comment.where(author_name: user.nickname).each do |comment_add_user_id|
      comment_add_user_id.user_id = user.id
      comment_add_user_id.save
    end
  end
end


desc 'Gets 10 most popular subreddits from reddit'
task :get_subreddits => :environment do
  subreddits_data = JSON.parse(RestClient.get 'https://www.reddit.com/reddits.json?sort=hot')
  subreddits_data["data"]["children"].first(10).each do |subreddit_data|
    Subreddit.find_or_create_by(name: subreddit_data["data"]["display_name"]) do |subreddit|
      subreddit.title = subreddit_data["data"]["title"]
      subreddit.description = subreddit_data["data"]["description"].truncate(50)
    end
  end
end

desc 'Gets live posts and comments for all our subreddits from reddit'
task :get_posts => :environment do
  subreddits = Subreddit.all
  subreddits.each do |subreddit|
    json = JSON.parse(RestClient.get "http://www.reddit.com/r/#{subreddit.name}/new.json?sort=new")
    json["data"]["children"].first(10).each do |post_json|

      title = post_json["data"]["title"]
      author_name = post_json["data"]["author"]
      selftext = post_json["data"]["selftext"]
      if selftext == ""
        selftext = post_json["data"]["url"]
      end

      post = subreddit.posts.create(title: title, creator_name: author_name, content: selftext)

      permalink = post_json["data"]["permalink"]
      json_comments = JSON.parse(RestClient.get "http://www.reddit.com#{permalink}.json")
      json_comments[1]["data"]["children"].each do |comment_json|
        Comment.create(content: comment_json["data"]["body"], post_id: post.id, author_name: comment_json["data"]["author"])
      end
    end
  end
end
