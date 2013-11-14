class ContestsController < ApplicationController
  def new
    @contests = current_user.contests.build
  end
  
end
