class UserRanksController < ApplicationController

  include SessionsHelper

  def index
    @users = User.without_admin.order(:rank)
    @rank = UserRank.new
  end


  def new
    # @rank = UserRank.new
  end


  def create

    if params[:user_rank][:rank].present? &&  !params[:user_rank][:rank].blank?
      @vote_result = params[:user_rank][:rank]
      @hash_vote = JSON.parse @vote_result
      @new_tournament = Tournament.with_status('open')

      @hash_vote.each do |vote|
        @userRankItem = UserRank.new
        @userRankItem.user_id = vote["user_id"].to_i
        @userRankItem.rank = vote["rank"].to_i
        @userRankItem.tournament_id = @new_tournament.first.id
        @userRankItem.user_vote_id = getIdCurrentUser
        @userRankItem.save
      end
      render 'message'
    end

  end

  def user_rank_params
    params.require(:user_rank).permit(:user_id,:rank)
  end

end
