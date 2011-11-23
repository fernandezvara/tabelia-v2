class NotifierMailer < ActionMailer::Base
  default from: "Tabelia <no-reply@tabelia.com>"
  
  def comment_on_user(originator, receiver, comment)
    I18n.locale = receiver.language
    @originator = originator
    @receiver = receiver
    @comment = comment
    puts "Mail to: #{@receiver.email} - Subject: #{t('mail.comment_on_profile.subject', :originator_name => originator.name)}'"
    if @receiver.email.include?("change.me") == false and @receiver.email.include?("hotmail.com") == false
      mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.comment_on_profile.subject', :originator_name => originator.name)) do |format|
        format.text
        format.html { render :layout => 'tabeliamail' }
      end
    end
  end
  
  def comment_on_art(originator, receiver, comment, art)
    I18n.locale = receiver.language
    @originator = originator
    @receiver = receiver
    @comment = comment
    @art = art
    puts "Mail to: #{@receiver.email} - Subject: '#{t('mail.comment_on_art.subject', :originator_name => originator.name, :art_name => art.name)}'"
    if @receiver.email.include?("change.me") == false and @receiver.email.include?("hotmail.com") == false
      mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.comment_on_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
        format.text
        format.html { render :layout => 'tabeliamail' }
      end
    end
  end
  
  def user_publish_art(originator, receiver, art)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    @art = art
    puts "Mail to: #{@receiver.email} - Subject: '#{t('mail.user_publish_art.subject', :originator_name => originator.name, :art_name => art.name)}'"
    if @receiver.email.include?("change.me") == false and @receiver.email.include?("hotmail.com") == false
      mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.user_publish_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
        format.text
        format.html { render :layout => 'tabeliamail' }
      end
    end
  end
  
  def user_follows_user(originator, receiver)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    puts "Mail to: #{@receiver.email} - Subject: #{t('mail.user_follows_user.subject', :originator_name => originator.name)}"
    if @receiver.email.include?("change.me") == false and @receiver.email.include?("hotmail.com") == false
      mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.user_follows_user.subject', :originator_name => originator.name)) do |format|
        format.text
        format.html { render :layout => 'tabeliamail' }
      end
    end
  end
  
  def user_likes_art(originator, receiver, art)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    @art = art
    puts "Mail to: #{@receiver.email} - Subject: '#{t('mail.user_likes_art.subject', :originator_name => originator.name, :art_name => art.name)}'"
    if @receiver.email.include?("change.me") == false and @receiver.email.include?("hotmail.com") == false
      mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.user_likes_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
        format.text
        format.html { render :layout => 'tabeliamail' }
      end
    end
  end
end
