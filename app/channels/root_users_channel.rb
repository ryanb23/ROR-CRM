# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RootUsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "admin_users_channel_room" if current_user.admin?
  end

  def unsubscribed
    stop_all_streams
  end
end
