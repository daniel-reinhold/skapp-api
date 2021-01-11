class ParticipantsController < ApplicationController
  before_action :set_user
  before_action :set_sheet
  before_action :set_participant, only: [:update, :destroy]

  # <editor-fold desc="Constants" defaultstate="collapsed">

  DEFAULT_FIELDS = [:id, :name, :sheet_id]

  # </editor-fold>

  # <editor-fold desc="Actions" defaultstate="collapsed">

  # GET /user/1/sheets/1/participants
  def index
    @participants = Participant.all

    render :json => @participants.to_json(:only => DEFAULT_FIELDS), :status => OK
  end

  # POST /user/1/sheets/1/participants/create
  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      render :json => @participant.to_json(:only => DEFAULT_FIELDS), :status => CREATED
    else
      render :json => @participant.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # PATCH /user/1/sheets/1/participants/1/update
  def update
    if @participant.update(participant_params)
      render :json => @participant.to_json(:only => DEFAULT_FIELDS), :status => OK
    else
      render :json => @participant.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # DELETE /user/1/sheets/1/participants/1/delete
  def destroy
    if @participant.destroy
      render :json => {}, :status => NO_CONTENT
    end
  end

  # </editor-fold>

  # <editor-fold desc="Private methods" defaultstate="collapsed">

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_participant
    begin
      @participant = Participant.find(params[:id])
    rescue
      render :json => {:error => 'Participant not found'}, :status => NOT_FOUND
    end
  end

  def set_sheet
    begin
      @sheet = Sheet.find(params[:sheet_id])
    rescue
      render :json => {:error => 'Sheet not found'}, :status => NOT_FOUND
    end
  end

  def set_user
    begin
      @user = User.find(params[:user_id])
    rescue
      render :json => {:error => 'User not found'}, :status => NOT_FOUND
    end
  end

  def set_game
    begin
      @game = Game.find(params[:game_id])
    rescue
      render :json => {:error => 'Game not found'}, :status => NOT_FOUND
    end
  end

  # Only allow a trusted parameter "white list" through.
  def participant_params
    params.permit(:name, :sheet_id)
  end

  # </editor-fold>

end
