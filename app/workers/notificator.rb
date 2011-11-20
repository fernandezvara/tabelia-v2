# encoding: UTF-8
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
    
    _what    = data['what']
    _who     = data['who']
    _when    = data['when']
    _to      = data['to']       if data['to']
    _comment = data['comment']  if data['comment']
    _art     = data['art']      if data['art']
    
    originator = User.find(_who)
    
    # work with data
    case _what
    when 'cou'
      receiver = User.find(_to)
      comment  = User.find(_to).comments_received.find(_comment)
    when 'coa'
      art = Art.find(_art)
      comment  = Art.find(_art).artcomments.find(_comment)
      receiver = art.user
    when 'upa'
      art = Art.find(_art)
      receivers = GraphClient.get("Backward", "Follow", originator) # All the ppl following him/her
    when 'ufu'
      receiver = User.find(_to)
    when 'ula'
      art = Art.find(_art)
      receiver = art.user
    end
    
    # adding to statistics (Stat...)
    case _what
    when 'cou'
      if Stat.count(:conditions => {:st_type => receiver.class.to_s, :st_id => receiver.id.to_s}) == 0
        stat = Stat.create(:st_type => receiver.class.to_s, :st_id => receiver.id.to_s)
      else
        stat = Stat.where(:st_type => receiver.class.to_s, :st_id => receiver.id.to_s).first
      end
      stat.comments.inc
      stat.save!
    when 'coa'
      if Stat.count(:conditions => {:st_type => art.class.to_s, :st_id => art.id.to_s}) == 0
        stat = Stat.create(:st_type => art.class.to_s, :st_id => art.id.to_s)
      else
        stat = Stat.where(:st_type => art.class.to_s, :st_id => art.id.to_s).first
      end
      stat.comments.inc
      stat.save!
    when 'ufu'
      if Stat.count(:conditions => {:st_type => receiver.class.to_s, :st_id => receiver.id.to_s}) == 0
        stat = Stat.create(:st_type => receiver.class.to_s, :st_id => receiver.id.to_s)
      else
        stat = Stat.where(:st_type => receiver.class.to_s, :st_id => receiver.id.to_s).first
      end
      stat.follows.inc
      stat.save!
    when 'ula'
      if Stat.count(:conditions => {:st_type => art.class.to_s, :st_id => art.id.to_s}) == 0
        stat = Stat.create(:st_type => art.class.to_s, :st_id => art.id.to_s)
      else
        stat = Stat.where(:st_type => art.class.to_s, :st_id => art.id.to_s).first
      end
      puts stat.likes.today
      stat.likes.inc
      puts stat.likes.today
    end
    
    begin
    
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
    
    rescue
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
    
    activity.to      = _to        if _to
    activity.art     = _art       if _art
    activity.comment = _comment   if _comment
    
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
  
    # add this activity to all the members that must have it in their activity feed, others than originator
    
    if members_to_notify.include?(originator) == true
      members_to_notify.delete(originator)
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
    
    # publish on facebook & twitter
    # obtenemos las autorizaciones del usuario, después por cada una realizamos las acciones, si es twitter, si es facebook...
    auths_of_originator = originator.authorizations
    auths_of_originator.each do |auth|
      case auth.provider
      when 'twitter'
        # TODO: falta validar que el usuario permita hacerlo!!!!
        if auth.tw_token.nil? == false and auth.tw_secret.nil? == false
          begin
            #configuramos el cliente Twitter
            # la configuración necesita de dos modelos de validaciones:
            # consumer_key y consumer_secret validan la aplicacion 'tabelia'
            # oauth_token y oauth_token_secret validan al usuario que lo envía
            # configuramos al usuario originador:
            Twitter.configure do |config|
              # TODO: must be an environment variable
              config.consumer_key = 'bqe8mTvQ0eBsLr3jHTkg'
              config.consumer_secret= 'TBWeoQoVXWGshRNaRdu9VyzeX12BzQsHMZVaK5wLt4'
              config.oauth_token = auth.tw_token
              config.oauth_token_secret = auth.tw_secret
            end
            # en función del tipo de notificación es necesario escribir un texto u otro
            # lenguaje de envío...

            # mensaje ...
            receiver_twitter = receiver.authorizations.where(:provider => 'twitter').first rescue nil
            case _what
            when 'upa'
              # TODO : Must publish on behalf of the user and tabelia itself, better to do it below all
              case originator.language
               when 'es'
                 text = "He publicado '#{art.name}' http://www.tabelia.com/art/#{art.slug} #tabelia"
               when 'en'
                 text = "I have published '#{art.name}' http://www.tabelia.com/art/#{art.slug} #tabelia"
               end
            when 'ufu'
              case originator.language
              when 'es'
                if receiver_twitter.nil? == false and receiver_twitter.tw_username.nil? == false
                  text = "Me he hecho seguidor de @#{receiver_twitter.tw_username} http://www.tabelia.com/user/#{receiver.username} #tabelia"                
                else
                  text = "Me he hecho seguidor de #{receiver.name} http://www.tabelia.com/user/#{receiver.username} #tabelia"
                end
              when 'en'
                if receiver_twitter.nil? == false and receiver_twitter.tw_username.nil? == false
                  text = "I began following @#{receiver_twitter.tw_username} http://www.tabelia.com/user/#{receiver.username} #tabelia"                
                else
                  text = "I began following #{receiver.name} http://www.tabelia.com/user/#{receiver.username} #tabelia"
                end
              end
            when 'ula'
              case originator.language
              when 'es'
                if receiver_twitter.nil? == false and receiver_twitter.tw_username.nil? == false
                  text = "Me gusta '#{art.name}' de @#{receiver_twitter.tw_username} http://www.tabelia.com/art/#{art.slug} #tabelia"                
                else
                  text = "Me gusta '#{art.name}' de #{receiver.name} http://www.tabelia.com/art/#{art.slug} #tabelia"
                end
              when 'en'
                if receiver_twitter.nil? == false and receiver_twitter.tw_username.nil? == false
                  text = "I like '#{art.name}' by @#{receiver_twitter.tw_username} http://www.tabelia.com/art/#{art.slug} #tabelia"                
                else
                  text = "I like '#{art.name}' by #{receiver.name} http://www.tabelia.com/art/#{art.slug} #tabelia"
                end
              end
            end
            Twitter.update(text)
          rescue   Exception => e
            puts "Error enviando usuario twitter: #{e.message}"
          end
        end # if auth.tw_token.nil? == false and auth.tw_secret.nil? == false
      when 'facebook'
        # TODO: publish to facebook
        if auth.fb_token.nil? == false
          begin
            fb_user = FbGraph::User.me(auth.fb_token.to_s)
            case _what
            when 'ufu'
              fb_user.og_action!('tabelia:follow', :artist => "http://www.tabelia.com/user/#{receiver.username}")
            when 'ula'
              fb_user.og_action!('tabelia:like', :art => "http://www.tabelia.com/art/#{art.slug}", :artist => "http://www.tabelia.com/user/#{receiver.username}")
            end
          rescue
            puts 'Error al publicar en Facebook'
          end
            
        end # if auth.fb_token.nil? == false
      when 'google_oauth2'
        #nothing to do.... for now :)
      end
    end
    
    ##### tabelia stream on facebook and twitter
    begin
      case _what
      when 'upa'
        # twitter
        Twitter.configure do |config|
          # TODO: must be an environment variable
          config.consumer_key = 'bqe8mTvQ0eBsLr3jHTkg'
          config.consumer_secret= 'TBWeoQoVXWGshRNaRdu9VyzeX12BzQsHMZVaK5wLt4'
          config.oauth_token = '417036554-6RJxZsjPskuSfbIvNRqpk2bQtc3Pzlm0Gqpybw8S'
          config.oauth_token_secret = 'etbvn0bXhuIY3Psuj6Go3min1k51aGzJCeWQ8ZQ0I4'
        end
        text = "#{art.name} - #{originator.name} #tabelia http://www.tabelia.com/art/#{art.slug}"
        Twitter.update(text)
      end
    rescue Exception => e
      puts "Error twitter desde @tabelia_com: #{e.message}"
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
      # NotifierMailer.your_art_has_been_published(originater, art).deliver
    when 'ufu'
      # Sends a mail to the receiver if he/she allows it, telling that the originator begins following him/her
      NotifierMailer.user_follows_user(originator, receiver).deliver
    when 'ula'
      # Sends a mail to the receiver if he/she allows it, telling that the originator begins liking his/her art
      NotifierMailer.user_likes_art(originator, receiver, art).deliver
    end
    
    puts "#{Time.now.to_f - start} seg - notificator"
  end
end