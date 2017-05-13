class UserRanksController < ApplicationController



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

      @hash_vote.each do |vote|
        @userRankItem = UserRank.new
        @userRankItem.user_id = vote["user_id"].to_i
        @userRankItem.rank = vote["rank"].to_i
        @userRankItem.tournament_id = 1
        @userRankItem.user_vote_id = 23
        @userRankItem.save
      end
      redirect_to :action => 'message'
    end


=begin
    if @ranks.save
      redirect_to :action => 'message'
    else
      render :action => 'new'
    end
=end

  end

  def user_rank_params
    params.require(:user_rank).permit(:user_id,:rank)
  end

end