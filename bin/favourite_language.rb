#!/usr/bin/env ruby
# 
# (c) Callan Carr 2018
#
# This simple cli script will tell us a github user's favourite language
# using simple frequency analysis + the github public API.
require 'json'

# get github username
puts "please enter a github username"
username = gets()

# process username
username.strip!

# get data from api
puts "finding #{username}'s favourite language"
data = JSON.parse(`curl -s https://api.github.com/users/#{username}/repos`)

# repo not found!
if !data[0] && data["message"].to_s.include?("Not Found")
  puts "no repos found for user #{username}."
  exit
end

# calculate most frequently occuring language. this simple algorithm uses O(n * 2) complexity.
dataset = {}
data.each do |repo|
  language = repo["language"]
  if !!repo["language"]
    occurances = dataset["#{language}"].to_i
    dataset["#{language}"] = occurances += 1
  end
end

# sort by order of frequency
sorted_data = dataset.sort { |a,b| a[1] <=> b[1] }
puts "#{sorted_data.last[0]} is #{username}'s favourite language!"