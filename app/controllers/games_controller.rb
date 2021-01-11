class GamesController < ApplicationController
  before_action :set_user
  before_action :set_sheet
  before_action :set_participant, only: [:set_points]
  before_action :set_game, only: [:show, :update, :destroy, :set_points]

  # <editor-fold desc="Constants" defaultstate="collapsed">

  DEFAULT_FIELDS                    = [:id, :sheet_id]
  PARTICIPANT_RESULT_DEFAULT_FIELDS = [:id, :participant_id, :game_id]

  # </editor-fold>

  # <editor-fold desc="Actions" defaultstate="collapsed">

  # GET /users/1/sheets/1/games
  def index
    @games = Game.all

    render :json => @games.to_json(:only => DEFAULT_FIELDS), :status => OK
  end

  def show
    render :json => @game.to_json(:only => DEFAULT_FIELDS, :include => {
        :participant_results => { :only => PARTICIPANT_RESULT_DEFAULT_FIELDS }
    }), :status  => OK
  end

  # POST /users/1/sheets/1/games/create
  def create
    @game = Game.new(game_params)

    if @game.save
      render :json => @game.to_json(:only => DEFAULT_FIELDS), :status => CREATED
    else
      render :json => @game.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # PATCH /users/1/sheets/1/games/1/update
  def update
    if @game.update(game_params)
      render :json => @game.to_json(:only => DEFAULT_FIELDS), :status => OK
    else
      render :json => @game.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # DELETE /users/1/sheets/1/games/1/destroy
  def destroy
    if @game.destroy
      render :json => {}, :status => NO_CONTENT
    end
  end

  # POST /users/1/sheets/1/games/1/setpoints?participant_id=1&points=53
  def set_points
    participant_result = ParticipantResult.create({
                                                      :result         => params[:points],
                                                      :participant_id => @participant.id,
                                                      :game_id        => @game.id
                                                  })

    if participant_result.save
      render :json => @game.to_json(:only => DEFAULT_FIELDS, :include => {
          :participant_results => { :only => PARTICIPANT_RESULT_DEFAULT_FIELDS }
      })
    else
      render participant_result.errors, :status => UNPROCESSABLE_ENTITY
    end
  end

  # </editor-fold>

  # <editor-fold desc="Private methods" defaultstate="collapsed">

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    begin
      @game = Game.find(params[:id])
    rescue
      render :json => { :error => 'Game not found' }, :status => NOT_FOUND
    end
  end

  def set_sheet
    begin
      @sheet = Sheet.find(params[:sheet_id])
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

  def set_participant
    begin
      @participant = Participant.find(params[:participant_id])
    rescue
      render :json => { :error => 'Participant not found' }, :status => NOT_FOUND
    end
  end

  # Only allow a trusted parameter "white list" through.
  def game_params
    params.permit(:sheet_id)
  end

  def participant_result_params
    params.permit(:result, :participant_id)
  end

  # </editor-fold>

end
