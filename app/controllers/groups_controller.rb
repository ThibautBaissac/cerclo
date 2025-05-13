class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update]

  def index
    @groups = filter_groups
    @topics = Topic.all
  end

  def show
    @group = Group.joins(:members).find_by(uuid: params[:id])
    @next_session = @group.next_session
  end

  def new
    @group = Group.new
    @topics = Topic.all
  end

  def create
    @group = current_user.facilitated_groups.build(group_params)
    @group.facilitator = current_user

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      @topics = Topic.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @topics = Topic.all
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      @topics = Topic.all
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group = Group.find_by(uuid: params[:id])
  end

  def group_params
    params.require(:group).permit(
      :title,
      :sub_title,
      :description,
      :topic_id,
      :min_participants,
      :max_participants,
      :duration,
      :frequency
    )
  end

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
