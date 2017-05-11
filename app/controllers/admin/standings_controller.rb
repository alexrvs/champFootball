class Admin::StandingsController < ApplicationController

  layout 'admin/admin'


  def index
    @teams = Team.find(53)
    Team.select('')
    Team.('SELECT *, count(*) AS count_matches_all,
                            (SELECT  count(*) FROM matches WHERE matches.team1_id = teams.id AND matches.team1_score <> 0) as count_matches_wins,
                            (SELECT  count(*) FROM matches WHERE matches.team1_id = teams.id AND
                                                                 (matches.team1_score = 0 AND matches.team2_score > 0 )) as count_matches_lose,
                            (SELECT SUM(team1_score) FROM matches  WHERE matches.team1_id = teams.id GROUP BY teams.id) as all_team1_score,
                            (SELECT SUM(team2_score) FROM matches  WHERE matches.team2_id <> teams.id
                                                                         AND matches.team1_id = teams.id GROUP BY teams.id) as all_missed_goals
                          FROM teams LEFT JOIN matches ON (teams.id = matches.team1_id)
                          WHERE teams.id = ?
                          GROUP BY teams.id, matches.team1_id, matches.id', 53)
    @st = Team.standings(@teams.id)

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
