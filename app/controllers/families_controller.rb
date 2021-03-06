class FamiliesController < ApplicationController
  
  def family_params
    params.require(:family).permit(:family_name, :hobbies, :skills, :activites, :committees, :membership)
  end

  def show
    @family = Family.find(params[:id])
    @people = @family.people
    @user ||= User.find(session[:user_id]) if session[:user_id]

    if @user.can_revoke?
        @submittals = @family.submittals.order("created_at DESC").limit(5)
    else
        @submittals = @family.submittals.where(:reviewed => true).order("created_at DESC").limit(5)
    end
  end

  def index
    @user ||= User.find(session[:user_id]) if session[:user_id]
    @families = Family.all
    @people = {}
    @families.each { |family|
      people = family.people
      @people[family.id] = people.all.to_json
    }
  end

  def new
    # Create form.
  end

  # If family already exists, error out. Else, create the family.
  def create
    # Modify change to family_name
    last_name = params[:person][:last_name]
    family = Family.find_by(family_name: last_name)
    if family != nil
      flash[:warning] = "#{family.family_name} already exists."
    elsif last_name == ""
      flash[:warning] = "Person1 needs a last name."
    else
      @family = Family.create(family_params)
      @family.family_name = last_name
      @family.save!
      if person2_params[:last_name] == ""
        @family.people.create!(person_params)
      else
        @family.people.create!([person_params, person2_params])
      end
      # Modify flash[:notice] for family's family_name to person1's last_name?
      flash[:notice] = "#{@family.family_name} was successfully created."
    end
    redirect_to families_path
  end

  def edit
    @user ||= User.find(session[:user_id]) if session[:user_id]
    @family = Family.find(params[:id])
    @people = @family.people
    @submittals = @family.submittals.order("created_at DESC").limit(5)
  end

  def update
    @family = Family.find(params[:id])
    @family.update_attributes!(family_params)
    flash[:notice] = "#{@family.family_name} was successfully updated."
    redirect_to families_path
  end

  def destroy
    Family.find(params[:id]).destroy
  end

end
