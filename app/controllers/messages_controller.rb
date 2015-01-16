class MessagesController < ApplicationController
  before_filter :authenticate
  def new
    @message = current_user.messages.new
  end

  def create
    users_ids = params[:users_ids].split(',').map(&:to_i).uniq
    users_ids.delete(current_user.id)
    key = users_ids.push(current_user.id).sort.join('-')
    conversation = mailbox.conversations.find_by_subject(key)
    recipients = User.where(id: users_ids)
    if conversation
      current_user.reply_to_conversation(conversation, params[:body])
    else
      current_user.send_message(recipients, params[:body], key)
    end
    redirect_to conversations_path
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find_by_id(params[:id])
  end
end
