class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  # <editor-fold desc="Constants" defaultstate="collapsed">

  DEFAULT_FIELDS = [:id, :display_name, :email]

  # </editor-fold>

  # <editor-fold desc="Actions" defaultstate="collapsed">

  # GET /users
  def index
    @users = User.all

    render :json => @users.to_json(:only => DEFAULT_FIELDS), :status => OK
  end

  # POST /users/create
  def create
    @user = User.new(user_params)

    if @user.save
      render :json => @user.to_json(:only => DEFAULT_FIELDS), :status => CREATED
    else
      render :json => @user.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render :json => @user.to_json(:only => DEFAULT_FIELDS), :status => OK
    else
      render :json => @user.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      render :json => {}, :status => NO_CONTENT
    end
  end

  # </editor-fold>

  # <editor-fold desc="Private methods" defaultstate="collapsed">

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    begin
      @user = User.find(params[:id])
    rescue
      render :json => { :error => 'User not found' }, :status => NOT_FOUND
    end
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:display_name, :email, :password)
  end

  # </editor-fold>

end
