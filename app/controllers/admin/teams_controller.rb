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

  # 4. Генерация команд.

  #   После того как для турнира назначены все участники мы должны их разбить по командам.
  #   Каждый участник будет иметь ранг. Чем лучше человек играет, тем выше его ранг.
  #   Нужно придумать такой алгоритм, чтобы генерировать максимально сбалансированные команды на основе ранга участника.
  #   Предположим участвует 16 человек.
  #   Разделяем их на 2 группы по 8 человек — те кто имеет высокий ранг и те кто имеет низкий ранг.
  #   Для каждого человека с первой группы система должна найти человека со второй группы.
  #   При этом для самого сильного игрока нужно постараться найти самого слабого.
  #   Но! Должна присутствовать и доля рандома.
  #   Не должно быть так, чтобы всегда для 1-го по рангу игрока находило 16-го, для 2-го — 15 , 3 -14 и тд.
  #   Нужно добавить либо погрешность либо окрестность из которой будет выбираться напарник.
  #   Название команды должно генерироваться с имени и фамилии ее участников. Шаблон — Иван А. + Сергей Б.
  #   Также должна быть реализована ручная настройка команд.

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


  def team_params
    params.require(:team).permit(:name,:description, :points_count)
  end

end
