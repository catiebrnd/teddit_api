require 'rest-client'
require 'json'
require 'pry'

def calculate_upvotes(story, category)
  upvotes = 1

  upvotes *= 5 if story.downcase.include? 'cats' or category.downcase.include? 'cats'
  upvotes *= 8 if story.downcase.include? 'bacon' or category.downcase.include? 'bacon'
  upvotes *= 3 if story.downcase.include? 'food' or category.downcase.include? 'food'

  upvotes
end

url = 'http://reddit.com/r/cats.json'
response = RestClient.get(url)
parsed_response = JSON.parse(response)

posts = []

data = parsed_response['data']
shit = data['children']

shit.each do |post|

    title = post["data"]["title"]
    category = post["data"]["subreddit"]
    upvotes = calculate_upvotes(title, category)


  post = {title: title, category: category, upvotes: upvotes}

  posts << post

end

posts.each do |post|
  puts "Title: #{post[:title]}"
  puts "Category: #{post[:category].capitalize}"
  puts "Current Upvotes: #{post[:upvotes]}"
  puts
end
