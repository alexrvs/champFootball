class Admin::StandingsController < ApplicationController

  layout 'admin/admin'


  def index
    @standings = Team.all
  end


  def show
    @standings = Team.all

  end

  def new
    @standings = Team.new
  end

  def create
    @standings = Team.new(standings_params)
    if @standings.save
      redirect_to :action => 'show', :id => @standings.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @standings = Team.find(params[:id])

  end

  def edit
    @standings = Team.find(params[:id])
  end

  def update
    @standings = Team.find(params[:id])
    if @standings.update_attributes(params[:standings])
      redirect_to :action => 'show', :id => @standings.id
    elsif
    render 'update'
    end
  end



  def standings_params
    params.require(:standings).permit(:name,:description, :points_count)
  end



end
