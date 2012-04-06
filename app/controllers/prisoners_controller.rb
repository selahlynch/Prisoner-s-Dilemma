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

    passwords_entered = (!params[:prisoner][:password].blank?) && (!params[:prisoner][:password_confirmation].blank?)

    if passwords_entered
      values_for_update = params[:prisoner]
    else
      @prisoner.no_password_update = true
      values_for_update = params[:prisoner].except(:password, :password_confirmation)
    end

    if @prisoner.update_attributes(values_for_update) 
      flash[:notice] = "Prisoner updated."
      redirect_to(:action => 'list')
    else
      flash[:notice] = @prisoner.errors.full_messages.join("\n")
      print  @prisoner.errors.inspect
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
