class Admin::TeamsController < ApplicationController
  layout 'admin/admin'

  before_action :find_team, only: [:show, :edit, :destroy, :update]

  def index
    @teams = Team.all.order(:id)
  end

  def show
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
  end

  def edit
  end

  def update
    if @team.update_attributes(team_params)
      redirect_to :action => 'show', :id => @team.id
    elsif
    render 'update'
    end
  end

  # Generate team

  def generate
    Team.generate
    redirect_to :action => 'index'
  end


  def generate_rank_user

    @userRank = User.without_admin
    @userRank.each do |user|
      @averageRank = UserRank.avg_rank user.id
      user.rank = @averageRank.to_i
      user.save
    end
    redirect_to :action => 'index'
  end


  def team_params
    params.require(:team).permit(:name,:description, :points_count)
  end

  def find_team
    @team = Team.find(params[:id])
  end

end
