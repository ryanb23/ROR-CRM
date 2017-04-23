# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PushNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "push_notifications:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
