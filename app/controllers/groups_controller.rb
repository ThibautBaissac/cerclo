class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.joins(:members).find_by(uuid: params[:id])
    @next_session = @group.next_session
  end
end
