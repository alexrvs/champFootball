class Admin::MatchesController < ApplicationController

  layout 'admin/admin'

  def index
    unless params[:match].nil?
      if params[:match][:team_name].present? &&  !params[:match][:team_name].blank?
        @matches = Match.with_team( params[:match][:team_name])
      elsif params[:match][:player_name].present? && !params[:match][:player_name].blank?
        @matches = Match.with_player(params[:match][:player_name])
      end
    else
      @matches = Match.order(:id)
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

    if @match.update_attributes!(match_params)
      redirect_to  :action => 'index'
    else
      render :edit
    end

  end

  # 5. Генерация матчей.
  #     Для раунда типа «регулярный чемпионат» нужно указать сколько матчей должна сыграть каждая команда с другой командой матчи
  #     и нажать кнопку «генерировать». Создастся столько матчей  чтобы все сыграли со всеми столько матчей, сколько было указано.
  #     Для раунда типа «Плей-офф» нужно сделать возможность добавлять матчи с указанием какой это
  #     тур(1/8,1/4,1/2, финал, матч за 3-е место).
  # {N(N-1) \ 2}


  def generate

    @count = @teams.count - (@teams.count - 1)
    @current_tournament = Tournament.find_by(:tournament_type_id => 3)
    @current_round = Round.first

    @teamsIds = Team.all.ids
    @teamCouple = @teamsIds.combination(2).to_a

    @teamCouple.each do |t1_c_id, t2_c_id|
          @match = Match.new
          @match.tournament_id = @current_tournament.id
          @match.round_id = @current_round.id
          @match.team1_id = t1_c_id
          @match.team2_id = t2_c_id
          @match.count_matches = 1
          @match.save
        end
    redirect_to :controller => 'matches', :action => 'index'
  end


  def match_params
    params.require(:match).permit(:team1_score, :team2_score)
  end
  
end
