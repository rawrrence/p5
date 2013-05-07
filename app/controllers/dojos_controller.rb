class DojosController < ApplicationController
	require 'will_paginate/array'

	def index
		@dojos = Dojo.active.alphabetical.paginate(:page => params[:page]).per_page(10)
		@inactive_dojos = Dojo.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def show
		@dojo = Dojo.find(params[:id])
		@members = @dojo.current_students.paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@dojo = Dojo.new
	end

	def create
		@dojo = Dojo.new(params[:dojo])
		if @dojo.save
      # if saved to database
      flash[:notice] = "Successfully created #{@dojo.name} dojo."
      redirect_to @dojo # go to show student page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def edit
  	@dojo = Dojo.find(params[:id])
  end

  def update
  	@dojo = Dojo.find(params[:id])
  	if @dojo.update_attributes(params[:dojo])
      flash[:notice] = "Successfully updated #{@dojo.name} dojo."
      redirect_to @dojo
    else
      render :action => 'edit'
    end
  end

	def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy
    flash[:notice] = "Successfully removed #{@dojo.name} from karate tournament system"
    redirect_to dojos_url
  end

end