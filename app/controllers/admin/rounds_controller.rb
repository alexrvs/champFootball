class Admin::RoundsController < ApplicationController

  before_action :find_match, only: [:show, :destroy, :edit, :update]

  layout 'admin/admin'

  def index
    @rounds = Round.all
  end

  def show
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
    @round.destroy
  end

  def edit
  end

  def update
    if @round.update_attributes(params[:rounds])
      redirect_to :action => 'show', :id => @round.id
    elsif
    render 'update'
    end
  end

  def round_params
    params.require(:round).permit(:name)
  end

  private

  def find_round
    @round = Round.find(params[:id])
  end
end
