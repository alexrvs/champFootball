class UserRanksController < ApplicationController

  include SessionsHelper

  def index
    @users = User.without_admin.order(:rank)
    @rank = UserRank.new
  end

  def create

    if params[:user_rank][:rank].present? &&  !params[:user_rank][:rank].blank?
      @vote_result = params[:user_rank][:rank]

      @hash_vote = JSON.parse @vote_result

      @new_tournament = Tournament.with_status('open')
      alreadyVoteUser = UserRank.find_by(:user_vote_id => getIdCurrentUser)
       if alreadyVoteUser.nil?
        @hash_vote.each do |vote|
          vote["tournament_id"] = @new_tournament.first.id
          vote["user_vote_id"] = getIdCurrentUser
        end
        UserRank.new_vote @hash_vote
        flash.now[:success] = "Your vote will be counted in the next tournament. Thanks for voting!"
       else
        flash.now[:success] = "You have already voted. You can to vote in next tournament!"
       end
      redirect_to :controller => 'welcome', :action => 'index'
    end

  end

  def user_rank_params
    params.require(:user_rank).permit(:user_id,:rank)
  end

end
