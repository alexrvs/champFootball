class Admin::TournamentsController < ApplicationController

  before_action :find_tournament, only: [:show, :destroy, :update]
  layout 'admin/admin'


  def index
    @tournaments = Tournament.all
  end

  def show
  end

  def new
    @tournament = Tournament.new
    @tournaments_type = TournamentType.all
    byebug
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to :action => 'show', :id => @tournament.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @tournament.destroy
  end

  def edit
    @tournaments_type = TournamentType.all
  end

  def update
    if @tournament.update_attributes(tournament_params)
      redirect_to  :action => 'index'
    else
      render :edit
    end
  end

  def addTeamToTournament
  end

  def tournament_params
    params.require(:tournament).permit(:name,:description,:tournament_type_id)
  end

  private

  def find_tournament
    @tournament = Tournament.find(params[:id])
  end
end
