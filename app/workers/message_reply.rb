class MessageReply

  @queue = :messaging
  
  def self.perform(from, conversation_id, text)
    user_from = User.find(from)
    conversation = Conversation.find(conversation_id)
    
    message = Message.new
    message.sender = user_from
    message.text = text
    
    if message.reply!(conversation) == true
      conversation.other_participants_than(user_from).each do |participant|
        Juggernaut.publish(participant.username, { msg: { sender: "#{user_from.name.to_s}", subject: "#{conversation.subject}" }})
        messages_count = participant.unreaded_conversations
        if messages_count == 0
          Juggernaut.publish(participant.username, { mc: 'o' })
        else
          Juggernaut.publish(participant.username, { mc: "#{messages_count}" })
        end
        puts "#{participant.username} -> #{messages_count} msg."
      end
    else
      raise
    end
  end
end