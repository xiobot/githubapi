# Introduction
This is a simple rails App to fulfil a tech demo. The app contains a command line program written in ruby which uses the github API to guess what a users favourite language is.

This task was completed in just under an hour.

# Instructions
To view the simple command line app that estimates a github user's favourite programming language; navigate to 
`bin/favourite_language.rb`


You can run the command line program by cloning this repo and running the following command:

```bash
bin/favourite_language.rb
```

The CSS/HTML demo is available by running the rails server and nagivating to '/'

# Favourite Language Source

``` ruby
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
```

# HTML/CSS test source

## HTML
``` html
<div class="link-container">
  <div class="link-unit completed">
    age + postcode
  </div>
  <div class="link-unit">
    about you
  </div>
  <div class="link-unit">
    your kit
  </div>
  <div class="link-unit">
    contact + delivery
  </div>
  <div class="link-unit">
    more about you
  </div>
  <div class="link-unit">
    confirm + pay
  </div>
</div>
```

## CSS
``` css
body {
  margin: 0;
}
 
.link-container {
  background: #ffc300;
  width: 100%;
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.link-unit {
  padding: 12px;
  font-weight: 700;
  font-family: sans-serif;
  font-size: 15px;
  text-transform: uppercase;
  font-family: Roboto;
  border-bottom: solid;
  border-color: #fff;
}

.completed {
  border-color: #000 !important;
}
```