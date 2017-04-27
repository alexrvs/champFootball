class Admin::TournamentTypesController < ApplicationController
  layout 'admin/admin'


  def index
    @tournamenttypes = TournamentType.all
  end


  def show
    @tournamenttype = TournamentType.find(params[:id])

  end

  def new
    @tournamenttype = TournamentType.new
  end

  def create
    @tournamenttype = TournamentType.new(tournamenttype_params)
    if @tournamenttype.save
      redirect_to :action => 'show', :id => @tournamenttype.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @tournamenttype = TournamentType.find(params[:id])

  end

  def edit
    @tournamenttype = TournamentType.find(params[:id])
  end

  def update
    @tournamenttype = TournamentType.find(params[:id])
    if @tournamenttype.update_attributes(params[:tournamenttype])
      redirect_to :action => 'show', :id => @tournamenttype.id
    elsif
    render 'update'
    end
  end


  def tournamenttype_params
    params.require(:team).permit(:name)
  end
end
