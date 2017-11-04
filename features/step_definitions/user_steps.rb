Given("the following users exist:") do |table|
  table.hashes.each do |user|
    User.create user
  end
end

When("I delete user {string}") do |string|
  pending
  
  # I've tried this.
  # user = User.find_by_email(string)
  # visit "/user", :delete, :id => user.id

  # I've also tried this.
  # delete_user_path(User.find_by_email(string))
end
