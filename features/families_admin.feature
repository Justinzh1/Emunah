Feature: Admins should be able to create, update, and delete families
 
  As an admin of Emunah's congregation
  So that I have access to the features provided on the website
  I want to be able to create, update, and delete a family

Background: I should be on the home page and logged in.
  
  Given the following users exist:
  | email                 | password | full_name   | is_admin |
  | seth.martin@gmail.com | abcdef   | Seth Martin | Yes      |
  | wli2@berkeley.edu     | 123456   | Wayne Li    | No       |
  
  And the following families exist:
  | family_name |
  | fam1        |
  | fam2        |

  And the following people exist:
  | full_name | hebrew_name | birthday | home_address | telephone | telephone_type | email_address | employer | occupation | anniversary | is_child | discovery | hobbies | skills | activities | committees | allow_contact | family_id |
  | full1     | hebrew1     | birth1   | home1        | tele1     | tele_num_type1 | email1        | emplo1   | job1       | non1        | False    | outreach  | none    | none   | none       | com1       | yes           | 1         |
  | full2     | hebrew2     | birth2   | home2        | tele2     | tele_num_type2 | email2        | emplo2   | job2       | non2        | True     | born_into | none    | none   | none       | com2       | no            | 2         |

  And I am on the home page
  Then I should see "Welcome to Congregation B'nai Emunah's Internal Tool!"
  And I fill in "Email" with "seth.martin@gmail.com"
  And I fill in "Password" with "abcdef"
  And I press "Log In"
  Then I should see "Welcome Seth Martin"

Scenario: create a family
  When I go to the "Create Family" page
  And I fill in "Family" with "fam3"
  And I press "Create Family"
  Then I should see "fam3 was successfully created."

Scenario: only one unique family persists in database
  When I go to the "Create Family" page
  And I fill in "Family" with "fam1"
  And I press "Create Family"
  Then I should see "fam1 already exists."

Scenario: update a family name
  When I am on the edit family page for "fam1"
  When I fill in "Family Name" with "ultra_fam"
  And I press "Update Family"
  Then I should see "ultra_fam's family name was successfully updated."

Scenario: check person information 
  When I am on the show person page for "full1"
  Then I should see "Showing information for full1"

Scenario: add person to a family 
  When I am on the edit family page for "fam1"
  And I press "Add Person"
  And I fill in "full_name" with "full3"
  And I fill in "hebrew_name" with "hebrew3"
  And I fill in "birthday" with "birth3"
  And I fill in "home_address" with "home3"
  And I fill in "telephone" with "tele3"
  And I fill in "telephone_type" with "tele_num_type3"
  And I fill in "email_address" with "email3"
  And I fill in "employer" with "emplo3"
  And I fill in "occupation" with "job3" 
  And I fill in "anniversary" with "non3"
  And I press "Add"
  Then I should see "full3 was successfully added to fam1"

Scenario: delete a family
  When I delete family "wayne.li@gmail.com"
  Then I should see "Family deleted."
