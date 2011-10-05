class Notificator
  
  @queue = :notifications
  
  # activity types:
  #
  # cou | Comment on User
  # coa | Comment on Art
  # upa | User publish new Art
  # ufu | User follows User
  # ula | User likes Art
  
  def self.perform(data)
    
    start = Time.now.to_f
    
    _what = data['what']
    _who  = data['who']
    _when = data['when']
    _data = data['data']
    
    originator = User.find(_who)
    
    # work with data
    case _what
    when 'cou'
      receiver = User.find(_data['to'])
      comment  = User.find(_data['to']).comments_received.find(_data['comment'])
    when 'coa'
      art = Art.find(_data['art'])
      comment  = Art.find(_data['art']).artcomments.find(_data['comment'])
      receiver = art.user
    when 'upa'
      art = Art.find(_data['art'])
      receivers = GraphClient.get("Backward", "Follow", originator) # All the ppl following him/her
    when 'ufu'
      receiver = User.find(_data['to'])
    when 'ula'
      art = Art.find(_data['art'])
      receiver = art.user
    end
    
    # socket
    case _what
    when 'cou'
      Juggernaut.publish(receiver.username, { comment_profile: { posted_by: originator.name }}) # t("#{receiver.locale}.socket.#{_what}"))
    when 'coa'
      Juggernaut.publish(receiver.username, { comment_art: { posted_by: originator, art: art.name }})
    when 'upa'
    when 'ufu'
      Juggernaut.publish(receiver.username, { user_follow_you: { originator: originator.name }})
    when 'ula'
      Juggernaut.publish(receiver.username, { user_likes_art: { originator: originator.name, art: art.name }})
    end
    
    # notification
    #case _what
    #when 'cou'
    #  this_notification = receiver.notifications.where(:what => _what).first
    #  if this_notification.nil?
    #    create
    #  else
    #    update
    #  end
      
    #end
    
    # activity stream
    # An activity has 2 parts:
    #   Global,what, who, when
    #   Activitydata, all the rest...
    # 
    # when an user makes something we need to trigger the members that must be notified
    # so we have all followers of the originator (the one on who)
    # and the others that must be notified too (Example: if a comments on b, a and b followers must be notified), since a
    #      can or not be already a follower he will be notified
    # 
    # This is just the activity that an user sees on his own homepage
    # The activity that can be seen on the profile it's only that one that the user is the originator.
    activity = Activity.new
    activity.what = _what
    activity.user = originator
    activity.when = _when
    
    _data.each do |key, value|
      newdata = Activitydata.new
      newdata.key = key
      newdata.value = value
      activity.activitydatas << newdata
      newdata.save
    end
    activity.save

    # get all followers of the originator
    originator_followers = GraphClient.get('Backward', 'Follow', originator)

    case _what
    when 'cou'
      receiver_followers = GraphClient.get('Backward', 'Follow', receiver)
      members_to_notify = originator_followers | receiver_followers
    when 'coa'
      receiver_followers = GraphClient.get('Backward', 'Follow', receiver)
      members_to_notify = originator_followers | receiver_followers
    when 'upa'
      members_to_notify = originator_followers
    when 'ufu'
      receiver_followers = GraphClient.get('Backward', 'Follow', receiver)
      members_to_notify = originator_followers | receiver_followers
    when 'ula'
      receiver_followers = GraphClient.get('Backward', 'Follow', receiver)
      members_to_notify = originator_followers | receiver_followers
    end
  
    # add this activity to all the members that must have it in their activity feed
    # if the originator is not following the user or the 'thing' we need to add his own activity to his feed
    if members_to_notify.include?(originator) == false
      members_to_notify << originator
    end
    if receiver
      if members_to_notify.include?(receiver) == false
        members_to_notify << receiver
      end
    end
    members_to_notify.each do |member|
      useractivity = Useractivity.new
      useractivity.activity = activity
      useractivity.when = activity.when
      member.useractivities << useractivity
      useractivity.save
      member.save
    end
    
    
    # mail - last since it's the most time consuming task
    case _what
    when 'cou'
      # Sends a mail to the receiver if he/she allows it, telling that the originator has commented his/her profile
      NotifierMailer.comment_on_user(originator, receiver, comment).deliver
    when 'coa'
      # Sends a mail to the receiver if he/she allows it, telling that the originator has commented the art
      NotifierMailer.comment_on_art(originator, receiver, comment, art).deliver
    when 'upa'
      # Sends a mail to each follower of originator
      receivers.each do |receiver|
        NotifierMailer.user_publish_art(originator, receiver, art).deliver
      end
    when 'ufu'
      # Sends a mail to the receiver if he/she allows it, telling that the originator begins following him/her
      NotifierMailer.user_follows_user(originator, receiver).deliver
    when 'ula'
      # Sends a mail to the receiver if he/she allows it, telling that the originator begins liking his/her art
      NotifierMailer.user_likes_art(originator, receiver, art).deliver
    end
    
    puts "#{Time.now.to_f - start}"
  end
end