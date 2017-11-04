class FamiliesController < ApplicationController
  
  def family_params
    params.require(:family).permit(:family_name)
  end

  def person_params
    params.require(:person).permit(:full_name, :hebrew_name, :birthday,
      :home_address, :telephone, :telephone_type, :email_address, :employer,
      :occupation, :anniversary, :is_child, :discovery, :hobbies, :skills,
       :activities, :committees, :allow_contact)
  end

  def show

  end

  def index
    @user ||= User.find(session[:user_id]) if session[:user_id]
    if @user.is_admin
      @families = Family.all
    end
  end

  def new
    # Create form.
  end

  def new_person
    # Create form to add new person to family.
  end

  def add_person
    # If person already exists in family, error out. Else, add person to family.
    @family = Family.find(params[:id])
    person = @family.people.build(person_params)
    if person == nil
      flash[:notice] = "#{person.full_name} cannot be added."
      redirect_to new_person_path
    else
      person.save!
      flash[:notice] = "#{person.full_name} was successfully added to #{@family.family_name}!"
      redirect_to edit_family_path
    end
  end

  def show_person
    @person = Person.find(params[:person])
    @family = Family.find(params[:id])
    if @person == nil
      flash[:notice] = "No information for person?"
      redirect_to edit_family_path(@family)
    end
  end 

  # If family already exists, error out. Else, create the family.
  def create
    family_name = params[:family][:family_name]
    family = Family.find_by(family_name: family_name)
    if family != nil
      flash[:notice] = "#{family_name} already exists."
    else
      @family = Family.create!(family_params)
      flash[:notice] = "#{@family.family_name} was successfully created."
    end
    redirect_to families_path
  end

  def edit
    @family = Family.find(params[:id])
    @people = @family.people
  end

  def update
    @family = Family.find(params[:id])
    @family.update_attributes!(family_params)
    flash[:notice] = "#{@family.family_name}'s family name was successfully updated."
    redirect_to families_path
  end

  def destroy
    Family.destroy(params[:id])
    flash[:notice] = "Family deleted."
    redirect_to families_path
  end
end
