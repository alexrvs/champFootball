class Admin::TeamsController < ApplicationController
  layout 'admin/admin'


  def index
    @teams = Team.all
  end


  def show
    @team = Team.find(params[:id])

  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to :action => 'show', :id => @team.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @team = Team.find(params[:id])

  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to :action => 'show', :id => @team.id
    elsif
    render 'update'
    end
  end


  def team_params
    params.require(:team).permit(:name,:description)
  end
end
