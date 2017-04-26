class Admin::TournamentsController < ApplicationController
  layout 'admin/admin'


  def index
    @tournaments = Tournament.all
  end


  def show
    @tournament = Tournament.find(params[:id])

  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to :action => 'show', :id => @tournament.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])

  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      redirect_to :action => 'show', :id => @tournament.id
    elsif
      render 'update'
    end
  end


  def tournament_params
    params.require(:tournament).permit(:name,:description)
  end

end
