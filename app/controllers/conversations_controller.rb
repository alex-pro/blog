class ConversationsController < ApplicationController
  before_filter :authenticate
  helper_method :mailbox, :conversation

  def index
    @conversations ||= current_user.mailbox.inbox.all
  end

  def show
    conversation = current_user.mailbox.conversations.find_by_id(params[:id])
    @messages = conversation.messages
  end

  def reply
    current_user.reply_to_conversation(conversation, params[:message][:body])
    redirect_to conversation_path
  end

  def trashbin
    @trash = current_user.mailbox.trash.all
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to conversations_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :back
  end

  def empty_trash
    current_user.mailbox.empty_trash
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
