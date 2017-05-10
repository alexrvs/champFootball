class Admin::MatchesController < ApplicationController

  layout 'admin/admin'

  def index
    if  params[:team_name]
      @matches = Match.with_team(params[:team_name])
    else
      @matches = Match.all
    end
  end


  def index_generate
    @teams = Team.all
  end

  def show
    @match = Match.find(params[:id])

  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to :action => 'show', :id => @match.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @match = Match.find(params[:id])

  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
      redirect_to :action => 'show', :id => @match.id
    elsif
    render 'update'
    end
  end

  # 5. Генерация матчей.
  #     Для раунда типа «регулярный чемпионат» нужно указать сколько матчей должна сыграть каждая команда с другой командой матчи
  #     и нажать кнопку «генерировать». Создастся столько матчей  чтобы все сыграли со всеми столько матчей, сколько было указано.
  #     Для раунда типа «Плей-офф» нужно сделать возможность добавлять матчи с указанием какой это
  #     тур(1/8,1/4,1/2, финал, матч за 3-е место).
  # {N(N-1) \ 2}


  def generate

    @teams = Team.all
    @count = @teams.count - (@teams.count - 1)
    @current_tournament = Tournament.find_by(:tournament_type_id => 3)

    @teams.each do |team_first|
      @teams.each do |team_second|
        unless team_first == team_second
          team_first.matches
          @match = Match.new
          @match.tournament_id = @current_tournament.id
          @match.round_id = 1
          @match.team1_id = team_first.id
          @match.team2_id = team_second.id
          @match.save
        end
      end
    end

    redirect_to :controller => 'matches', :action => 'index'
  end


  def match_params
    params.require(:match).permit(:team_name)
  end
  
end
