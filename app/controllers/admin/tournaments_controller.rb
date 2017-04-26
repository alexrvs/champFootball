class Admin::TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.find()
  end


  def show
    @tournament = Tournament.find(params[:id])

  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])
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

end
