class SheetsController < ApplicationController
  before_action :set_user
  before_action :set_sheet, only: [:update, :destroy]

  # <editor-fold desc="Constants" defaultstate="collapsed">

  DEFAULT_FIELDS = [:id, :title, :user_id]

  # </editor-fold>

  # <editor-fold desc="Actions" defaultstate="collapsed">

  # GET /users/1/sheets
  def index
    @sheets = Sheet.all

    render :json => @sheets.to_json(:only => DEFAULT_FIELDS), :status => OK
  end

  # POST /users/1/sheets/create
  def create
    @sheet = Sheet.new(sheet_params)

    if @sheet.save
      render :json => @sheet.to_json(:only => DEFAULT_FIELDS), :status => CREATED
    else
      render :json => @sheet.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # PATCH /users/1/sheets/1/update
  def update
    if @sheet.update(sheet_params)
      render :json => @sheet.to_json(:only => DEFAULT_FIELDS), :status => OK
    else
      render :json => @sheet.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # DELETE /users/1/sheets/1/delete
  def destroy
    if @sheet.destroy
      render :json => {}, :status => NO_CONTENT
    end
  end

  # </editor-fold>

  # <editor-fold desc="Private methods" defaultstate="collapsed">

  private

  def set_sheet
    begin
      @sheet = Sheet.find(params[:id])
    rescue
      render :json => { :error => 'Sheet not found' }, :status => NOT_FOUND
    end
  end

  def set_user
    begin
      @user = User.find(params[:user_id])
    rescue
      render :json => { :error => 'User not found' }, :status => NOT_FOUND
    end
  end

# Only allow a trusted parameter "white list" through.
  def sheet_params
    params.permit(:title, :user_id)
  end

  # </editor-fold>
end
