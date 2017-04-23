App.push_notifications = App.cable.subscriptions.create "PushNotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log "received"
    # Update notification list
    $("#notification-list").html data.notification_template
    # Update unread notification count
    $(".notification span.badge").html data.notification_count
    # Alert with push notification
    Push.create data.title,
      body: data.description,
      icon: data.icon_url
      timeout: 4000,
      onClick: ->
        window.focus()
        window.location = data.redirect_url
        @close()
        return
