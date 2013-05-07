class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_student_options(registrations)
  	students = []
  	registrations.each do |r|
  		students << r.student
  	end
  	return students
  end
  helper_method :get_student_options



  def verify_standings(params)
  	student1 = params[:student1]
  	count = params[:count].to_i

  	if student1.blank?
  		return false
  	end

  	if count > 1
  		student2 = params[:student2]
  		if student2.blank?
  			return false
  		end
  		if student1 == student2
  			return false
  		end
  	end

  	if count > 2
  		student3 = params[:student3]
  		if student3.blank?
  			return false
  		end
  		if student1 == student3 || student2 == student3
  			return false
  		end
  	end
  	
  	return true
  end
  
  private
	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user

	def logged_in?
	  current_user
	end
	helper_method :logged_in?

	def check_login
	  redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
	end
end
