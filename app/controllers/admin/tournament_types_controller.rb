class Admin::TournamentTypesController < ApplicationController

  before_action :find_tournament_type, only: [:show, :edit, :destroy, :update]
  layout 'admin/admin'

  def index
    @tournament_types = TournamentType.all
  end

  def show
  end

  def new
    @tournament_type = TournamentType.new
  end

  def create
    @tournament_type = TournamentType.new(tournament_type_params)
    if @tournament_type.save
      redirect_to :action => 'show', :id => @tournament_type.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @tournament_type.destroy
  end

  def edit
  end

  def update
    if @tournament_type.update_attributes(tournament_type_params)
      redirect_to :action => 'index'
    else
    render :action => 'edit'
    end
  end


  def tournament_type_params
    params.require(:tournament_type).permit(:name)
  end

  private

  def find_tournament_type
    @tournament_type = TournamentType.find(params[:id])
  end
end
