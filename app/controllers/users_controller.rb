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
  
  def accept_friend
    @friend = User.find(params[:id])
    isAlreadyFriend = false
    current_user.friends.each do |user|
      if(@friend.id != user.id)
        isAlreadyFriend = true
        break
      end
    end
    if(isAlreadyFriend != true)
      current_user.accept_friendship(@friend)
    end
  end
end
