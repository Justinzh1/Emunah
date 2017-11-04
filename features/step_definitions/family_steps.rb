Given("the following families exist:") do |table|
  table.hashes.each do |family|
    Family.create family
  end
end

When("I delete family {string}") do |string|
  pending
  
  # I've tried this.
  # user = User.find_by_email(string)
  # visit "/user", :delete, :id => user.id

  # I've also tried this.
  # user_path User.find_by_email(string), method => :delete
end