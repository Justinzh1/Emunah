# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/ then '/home'
    when /^the dashboard page$/ then '/dashboard'
    
    when /^the "Create User" page$/ then '/users/new'
    when /^the "Create Family" page$/ then '/families/new'
    
    when /^the edit user page for "(.*)"$/ then
      edit_user_path(User.find_by_email($1))
    when /^the edit family page for "(.*)"/ then
      edit_family_path(Family.find_by_family_name($1))
    when /^the show person page for "(.*)"$/ then
      show_person_path(Person.find_by_full_name($1))

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
