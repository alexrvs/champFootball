class Tournaments < ApplicationController

  layout 'application'

  def index
    @tournaments = Tournament.all
  end

end