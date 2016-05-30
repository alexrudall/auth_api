module Api::V1
  class GroupsController < ApplicationController
    before_action :set_group, only: [:show, :update, :destroy]
    before_action :new_group, only: [:create]
    before_action :authorize_group, only: [:create, :update, :destroy]

    def index
      @groups = Group.all
      render json: @groups
    end

    def show
      render json: @group
    end

    def create
      if @group.save
        render json: @group, status: :created, location: v1_group_url(@group)
      else
        render json: @group.errors, status: :unprocessable_entity
      end
    end

    def update
      if @group.update(group_params)
        render json: @group
      else
        render json: @group.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @group.destroy
    end

    private

    def set_group
      @group = Group.find(params[:id])
    end

    def new_group
      @group = Group.new(group_params)
    end

    def authorize_group
      authorize Group
    end

    def group_params
      params.require(:group).permit(:name, user_ids: [])
    end
  end
end
