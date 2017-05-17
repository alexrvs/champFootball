class Admin::TeamsController < ApplicationController
  layout 'admin/admin'

  before_action :find_team, only: [:show]

  def index
    @teams = Team.all.order(:id)
  end

  def show
    @team = Team.find(params[:id])
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

  # Generate team

  def generate

    @usersTeam = User.without_admin.to_a
    @countTeams = (@usersTeam.count/2).to_i

    @countTeams.times do |i|
      Team.generate(@usersTeam)
    end

    redirect_to :action => 'index'
  end


  def generate_rank_user

    @userRank = User.without_admin
    @userRank.each do |user|
      @averageRank = UserRank.avg_rank user.id
      user.rank = @averageRank.to_i
      if user.valid?
        user.save
      end
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
