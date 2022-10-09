# Add a declarative step here for populating the DB with movies.

Given(/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @title = movie['title']
    @rating = movie['rating']
    @release_date = movie['release_date']

    Movie.create("title": @title, "rating": @rating)
  end
  # raise 'Unimplemented'
end

Then(/(.*) seed movies should exist/) do |n_seeds|
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  puts page.body
  bool = true
  bool.should be page.body.index(e1) < page.body.index(e2)
  # raise 'Unimplemented'
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When(/I (un)?check the following ratings: (.*)/) do |_uncheck, _rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # raise 'Unimplemented'
  if un
    for r in rating_list.split
      uncheck('ratings[' + r + ']')
    end
  else
    for r in rating_list.split
      check('ratings[' + r + ']')
    end
  end
  # fail "Unimplemented"
end

Then(/I should see all the movies/) do
  # Make sure that all the movies in the app are visible in the table
  count = -1
  page.all('tr').each do |_tr|
    count += 1
  end

  Movie.count.should be count
  # raise 'Unimplemented'
end
