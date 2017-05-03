class Admin::RoundsController < ApplicationController

  layout 'admin/admin'


  def index
    @rounds = Round.all
  end


  def show
    @round = Round.find(params[:id])

  end

  def new
    @round = Round.new
  end

  def create
    @round = Round.new(round_params)
    if @round.save
      redirect_to :action => 'show', :id => @round.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @round = Round.find(params[:id])
    @round.destroy
  end

  def edit
    @round = Round.find(params[:id])
  end

  def update
    @round = Round.find(params[:id])
    if @round.update_attributes(params[:rounds])
      redirect_to :action => 'show', :id => @round.id
    elsif
    render 'update'
    end
  end


  def round_params
    params.require(:round).permit(:name)
  end
  
end
