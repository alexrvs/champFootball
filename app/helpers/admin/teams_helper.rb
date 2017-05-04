module Admin::TeamsHelper

  def full_name_player(player)
    player.first_name + ' ' + player.last_name
  end
end
