class GroupsController < ApplicationController
  def index
    @groups = filter_groups
    @topics = Topic.all
  end

  def show
    @group = Group.joins(:members).find_by(uuid: params[:id])
    @next_session = @group.next_session
  end

  private

  def filter_groups
    GroupFilterService.new(filter_params).call
  end

  def filter_params
    params.permit(
      :topic_id,
      :category,
      :frequency,
      :availability,
      :date_from,
      :date_to
    )
  end
end
