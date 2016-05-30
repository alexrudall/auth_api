class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]

  def index
    @groups = Group.all
    render json: @groups
  end

  def show
    render json: @group
  end

  def create
    authorize Group
    @group = Group.new(group_params)
    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize Group
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize Group
    @group.destroy
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :user_ids => [])
  end

end
