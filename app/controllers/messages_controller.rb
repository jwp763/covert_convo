class MessagesController < ApplicationController
  before_action :authenticate_user!
 
  def new
  end
 
  def create
    #@user = User.find(params[:user])
    
    # if(@user)
    #   conversation = current_user.send_message(user, "", "#{@user.username}/#{current_user.username}").conversation
    #   flash[:success] = "Message has been sent!"
    #   redirect_to conversation_path(conversation)
    # else
    if params[:recipients].to_i > 0
      recipients = User.find_by(id: params['recipients'])
      #conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
      conversation = current_user.send_message(recipients, "#{current_user.username} has started a conversation!", "#{recipients.username}/#{current_user.username}").conversation
      current_user.mailbox.inbox.unshift(conversation)
      flash[:success] = "Message has been sent!"
      redirect_to conversation_path(conversation)
    elsif params[:recipients].to_i == 0
      recipients = current_user.random_interested_user
      if recipients == nil
        redirect_to conversations_path()
        return
      end
      conversation = current_user.send_message(recipients, "#{current_user.username} has started a conversation!", "#{recipients.username}/#{current_user.username}").conversation
      current_user.mailbox.inbox.unshift(conversation)
      flash[:success] = "Message has been sent!"
      redirect_to conversation_path(id: conversation.id, random: true)
    elsif params[:recipients].to_i == -1
      recipients = current_user.random_user
      if recipients == nil
        redirect_to conversations_path()
        return
      end
      conversation = current_user.send_message(recipients, "#{current_user.username} has started a conversation!", "#{recipients.username}/#{current_user.username}").conversation
      current_user.mailbox.inbox.unshift(conversation)
      flash[:success] = "Message has been sent!"
      redirect_to conversation_path(id: conversation.id, random: true)
    end
    
    
  end
end
