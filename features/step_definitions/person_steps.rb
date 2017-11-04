Given("the following people exist:") do |table|
  table.hashes.each do |person|
    Person.create person
  end
end
