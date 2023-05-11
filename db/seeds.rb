# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

Like.destroy_all
PrivateMessage.destroy_all
Comment.destroy_all
JoinTagGossip.destroy_all
Tag.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all

#Création des villes
10.times do 
  user = City.create!(name: Faker::Address.unique.city, zip_code: Faker::Address.unique.zip_code)
end 
current_city_ids = City.ids

#Création des users
10.times do 
  user = User.create!(first_name: Faker::Name.first_name, 
  last_name: Faker::Name.unique.last_name,
  description: Faker::Quote.unique.famous_last_words, 
  email: Faker::Internet.unique.email ,
  age: Faker::Number.between(from: 18, to: 100),
  city_id: current_city_ids.sample)
end 
current_user_ids = User.ids

#Création des gossips 
20.times do 
  user = Gossip.create!(title: Faker::Book.unique.title, 
  content: Faker::Lorem.paragraph, 
  user_id: current_user_ids.sample)
end 
current_gossip_ids = Gossip.ids

#Création des tags
10.times do 
  user = Tag.create!(title: Faker::Emotion.unique.noun)
end 
current_tag_ids = Tag.ids

#Création des JoinGossipTagg 
20.times do 
  user = JoinTagGossip.create!(gossip_id: current_gossip_ids.sample, tag_id: current_tag_ids.sample)
end 

 #Création des Comments
20.times do 
  user = Comment.create!(content: Faker::Lorem.paragraph, 
  gossip_id: current_gossip_ids.sample, 
  user_id: current_user_ids.sample)
end 
current_comment_ids = Comment.ids

#Création des PrivateMessages
5.times do 
 user1_id = current_user_ids.sample
 user2_id = current_user_ids.sample
 while user1_id == user2_id
   user2_id = current_user_ids.sample
 end 
 user = PrivateMessage.create!(sender:User.find(user1_id), 
 recipient:User.find(user2_id))
end 

#Création de like
type = ["Comment","Gossip"]
25.times do 
  user = Like.new
  user.imageable_type = type.sample 
  user.imageable_type == "Comment" ? user.imageable_id = current_comment_ids.sample : user.imageable_id = current_gossip_ids.sample
  user.user_id = current_user_ids.sample
  user.save
end 