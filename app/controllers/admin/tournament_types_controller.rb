class Admin::TournamentTypesController < ApplicationController
  layout 'admin/admin'


  def index
    @tournament_types = TournamentType.all
  end


  def show
    @tournament_type = TournamentType.find(params[:id])

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
    @tournament_type = TournamentType.find(params[:id])
    @tournament_type.destroy
  end

  def edit
    @tournament_type = TournamentType.find(params[:id])
  end

  def update
    @tournament_type = TournamentType.find(params[:id])
    if @tournament_type.update_attributes(params[:tournament_types])
      redirect_to :action => 'show', :id => @tournament_type.id
    elsif
    render 'update'
    end
  end


  def tournament_type_params
    params.require(:tournament_type).permit(:name)
  end
end
