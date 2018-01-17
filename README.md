# Instructions
To view the simple command line app that estimates a github user's favourite programming language; navigate to 
 * bin/favourite_language.rb


You can run this by cloning this repo and running:

`bin/favourite_language.rb`

The CSS/HTML demo is available by running the rails server and nagivating to '/'

# Favourite Language Source

```ruby
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
```html
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
```
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, or any plugin's
 * vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 *= require_tree .
 *= require_self
 */
 
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
  padding: 23px;
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