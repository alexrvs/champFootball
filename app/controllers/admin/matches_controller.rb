class Admin::MatchesController < ApplicationController

  layout 'admin/admin'


  def index
    @matches = Match.all
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
    @match = Match.new(tournament_params)
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
    if @match.update_attributes(params[:tournament])
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

    @count = @teams.count - 1

    @teams.each do |team_first|
      @teams.each do |team_second|
        unless team_first == team_second
          t1_id = team_first.id
          t2_id = team_second.id
          mathes = TeamMatch.new

        end
      end
    end
  end


  def tournament_params
    params.require(:tournament).permit(:name,:description)
  end
  
end
