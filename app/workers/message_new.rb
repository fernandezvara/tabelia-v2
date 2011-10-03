class MessageNew

  @queue = :messaging
  
  def self.perform(from, to, subject, text)
    user_from = User.find(from)
    user_to   = User.find(to)
    
    message = Message.new
    message.sender = user_from
    message.text = text
    
    if message.send!([user_to], subject) == true
      Juggernaut.publish(user_to.username, { msg: { sender: "#{user_from.name.to_s}", subject: "#{subject}" }})
      messages_count = user_to.unreaded_conversations
      if messages_count == 0
        Juggernaut.publish(user_to.username, { mc: 'o' })
      else
        Juggernaut.publish(user_to.username, { mc: "#{messages_count}" })
      end
      puts "#{user_to.username} -> #{messages_count} msg."
    else
      raise
    end
  end
  
end
  