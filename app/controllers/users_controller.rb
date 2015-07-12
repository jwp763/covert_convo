class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
  end

  def update
  end

  def delete
  end

  def show
    @users = User.find(params[:id])
  end
end
