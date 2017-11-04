class PeopleController < ApplicationController
  
  def person_params
    params.require(:person).permit(:full_name, :hebrew_name, :birthday,
      :home_address, :telephone, :telephone_type, :email_address, :employer,
      :occupation, :anniversary, :is_child, :discovery, :hobbies, :skills,
       :activities, :committees, :allow_contact)
  end

  def show
    @person = Person.find(params[:id])
  end

  def index
    # Unused. 
  end

  def new
    # Form to create. Admin only.
    
  end

  def create
    
  end

  def edit
    # Admin only.
    @person = Person.find(params[:id])

  end

  def update
    # Admin only
    @person = Person.find(params[:id])
    @person.update_attributes!(person_params)
    @family = @person.family
    flash[:notice] = "#{@person.full_name} was successfully updated."
    redirect_to edit_family_path(@family)
  end

  def destroy
    Person.destroy(params[:id])
    flash[:notice] = "Person deleted."
    redirect_to families_path
  end
end
