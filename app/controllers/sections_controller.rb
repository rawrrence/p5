class SectionsController < ApplicationController

  def index
    @sections = Section.alphabetical.paginate(:page => params[:page]).per_page(8)
  end

  def show
    @section = Section.find(params[:id])
    @section_students = @section.students.alphabetical
    @registration = Registration.new
  end
  
  def for_tournament
    @tournament = Tournament.find(params[:tournament_id])
    @sections = @tournament.sections.alphabetical.paginate(:page => params[:page]).per_page(8)
  end

  def edit_standings
    @section = Section.find(params[:id])
    @registrations = @section.registrations
    @students = get_student_options(@registrations)
  end

  def update_standings
    @section = Section.find(params[:id])
    @registrations = @section.registrations

    if verify_standings(params)
      @registrations.each do |r|
        r.final_standing = nil
        r.save!
      end

      params[:student1] = params[:student1].to_i
      params[:student2] = params[:student2].to_i
      params[:student3] = params[:student3].to_i

      @student1 = @registrations.find_by_student_id(params[:student1])
      @student2 = @registrations.find_by_student_id(params[:student2])
      @student3 = @registrations.find_by_student_id(params[:student3])

      @student1.final_standing = 1
      @student2.final_standing = 2
      @student3.final_standing = 3

      @student1.save!
      @student2.save!
      @student3.save!
      
      flash[:notice] = "Successfully updated standings"
      redirect_to @section
    else
      flash[:notice] = "Could not update the standings. Please double check your input."
      redirect_to edit_standings_path(@section)
    end
  end

  def new
    @section = Section.new
  end

  def edit
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(params[:section])
    if @section.save
      # if saved to database
      flash[:notice] = "Successfully created section."
      redirect_to @section # go to show section page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = "Successfully updated section."
      redirect_to @section
    else
      render :action => 'edit'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Successfully removed #{@section.name} from karate tournament system"
    redirect_to sections_url
  end
end