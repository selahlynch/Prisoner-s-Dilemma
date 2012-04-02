class PrisonersController < ApplicationController

  before_filter :confirm_logged_in
  before_filter :confirm_admin

  def new
    #@prisoner = Prisoner.new(:name => "Some Name")  ##this is not actually necessary
    @prisoner = Prisoner.new
  end

  def create
    @prisoner = Prisoner.new(params[:prisoner])
    if @prisoner.save 
      flash[:notice] = "Prisoner created."
      redirect_to(:action => 'list')
    else
      flash[:notice] = "Prisoner creation failed."
      render 'new'  ##just rendering template, not running controller function
    end
  end
  
  def index
    list
    render('list')
  end
  
  def list
    @prisoners = Prisoner.all
    #@prisoners = Prisoner.order("prisoners.name ASC")
  end

  def show
    @prisoner = Prisoner.find(params[:id])
  end

  def edit
    @prisoner = Prisoner.find(params[:id])    
  end

  def update
    @prisoner = Prisoner.find(params[:id])
    if @prisoner.update_attributes(params[:prisoner]) 
      flash[:notice] = "Prisoner updated." 
      redirect_to(:action => 'list')
      #redirect_to(:actions => 'show', :id => @prisoner.id, :junk = 'junk')
    else
      render 'edit'  ##just rendering template, not running controller function
    end
 
  end

  def delete
    @prisoner = Prisoner.find(params[:id])
  end

  def destroy
    Prisoner.find(params[:id]).destroy
    flash[:notice] = "Prisoner destroyed."
    redirect_to(:action => 'list')
  end
  
end
