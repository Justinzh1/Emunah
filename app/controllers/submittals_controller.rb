class SubmittalsController < ApplicationController

    def submittal_params
        params.require(:submittal).permit(:title, :notes, :family_id)
    end

    def new
        @family = Family.find(params[:family_id])
    end

    def show
        @submittal = Submittal.find(params[:id])
    end

    def edit
        @family = Family.find(params[:family_id])
        @submittal = Submittal.find(params[:id])
    end

    def index
        @user ||= User.find(session[:user_id]) if session[:user_id]
        @family = Family.find_by(params[:family_id])
        @people = Family.people.pluck(:first_name, :last_name)
        @submittals = @family.submittals
    end

    def create
        @family = Family.find(params[:family_id])
        params = submittal_params
        title = params[:title]
        notes = params[:notes]
        if !title.nil? and !notes.nil? and !title.empty? and !notes.empty?
            @family.submittals.build(submittal_params.merge(:family_name => @family.family_name)).save!
            redirect_to family_path(@family), :flash => { :success => "Submittal successfully created for family: #{@family.family_name}"}
        else
            redirect_to new_family_submittal_path(@family.id), :flash => { :error => "Please fill out all fields"}
        end
    end

    def destroy
        submittal = Submittal.find_by_id_and_family_id(params[:id], params[:family_id])
        submittal.destroy!
    end

    def approve
        @user ||= User.find(session[:user_id]) if session[:user_id]
        if @user.can_revoke?
            submittal = Submittal.find(params[:submittal_id])
            submittal.approve
            submittal.save!
            redirect_to family_path(params[:family_id]), :flash => { success: "Submittal was successfully approved."}
        else
            redirect_to family_path(params[:family_id]), :flash => { error: "Unauthorized"}
        end
    end

    def revoke
        @user ||= User.find(session[:user_id]) if session[:user_id]
        if @user.can_revoke?
            submittal = Submittal.find(params[:submittal_id])
            submittal.revoke
            submittal.save!
            redirect_to family_path(params[:family_id]), :flash => { success: "Submittal was successfully revoked."}
        else
            redirect_to family_path(params[:family_id]), :flash => { error: "Unauthorized"}
        end
    end 

end
