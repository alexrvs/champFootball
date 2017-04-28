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

    @countUsers = User.count - 1
    @users = User.all.to_a
    @users.each do |user|
      unless user.is_admin
        user.update_attribute(:rank,[*1..@countUsers].sample)
      end
    end

    @countTeams = @countUsers/2.to_i
    @countTeams.times do |i|
      @team = Team.new
      @team.name = 'Team ' + i.to_s
      @team.description = 'Default Description ' + @team.name.to_s
      @team.points_count = i
      @team.save
        2.times do |j|
          unless @users.last.is_admin
            @users.last.update_attribute(:team_id, @team.id)
            @users.pop
          end
        end
    end
    redirect_to :action => 'index'
  end


  def team_params
    params.require(:team).permit(:name,:description, :points_count)
  end

end
