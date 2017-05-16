class Admin::TeamsController < ApplicationController
  layout 'admin/admin'


  def index
    @teams = Team.all.order(:id)
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

  # Generate team

  def generate

    @usersTeam = User.without_admin.to_a
    @countTeams = (@usersTeam.count/2).to_i

    @countTeams.times do |i|
      @team = Team.new
      @team.name = 'Team ' + (i+1).to_s
      @team.description = 'Default Description' + @team.name.to_s
      @team.points_count = (i+1).to_i

      @team.first_player = @usersTeam.max { |a, b| a.rank <=> b.rank }
      @team.user1_id = @team.first_player.id
      @usersTeam.delete_if{ |u| u.id == @team.first_player.id }

      @team.second_player = @usersTeam.min { |a, b| a.rank <=> b.rank }
      @team.user2_id = @team.second_player.id
      @usersTeam.delete_if{ |u| u.id == @team.second_player.id }

      @team.save
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

end
