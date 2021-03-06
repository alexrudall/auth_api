module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :new_user, only: [:create]

    def index
      @users = User.all
      render json: @users
    end

    def show
      render json: @user
    end

    def create
      if @user.save
        render json: @user, status: :created, location: v1_user_url(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def new_user
      @user = User.new(user_params)
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  end
end
