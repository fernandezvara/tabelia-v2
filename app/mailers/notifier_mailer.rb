class NotifierMailer < ActionMailer::Base
  default from: "Tabelia <no-reply@tabelia.com>"
  
  def admin_art_published(user, art)
    @user = user
    @art = art
    mail(:to => "Admin <admin@tabelia.com>", :subject => 'Nueva obra publicada') do |format|
      format.html { render :layout => 'tabeliamail' }
    end
  end
  
  def confirmation(user)
    I18n.locale = user.language do
      @user = user
      puts "Mail to: #{@user.email} - Subject: #{t('mail.confirmation.subject', :user_name => user.name)}'"
      mail(:to => "#{@user.name} <#{@user.email}>", :subject => t('mail.confirmation.subject', :user_name => user.name)) do |format|
        format.text
        format.html { render :layout => 'tabeliamail' }
      end
    end
  end
  
  def comment_on_user(originator, receiver, comment)
    I18n.locale = receiver.language
    @originator = originator
    @receiver = receiver
    @comment = comment
    puts "Mail to: #{@receiver.email} - Subject: #{t('mail.comment_on_profile.subject', :originator_name => originator.name)}'"
    mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.comment_on_profile.subject', :originator_name => originator.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end

  end
  
  def comment_on_art(originator, receiver, comment, art)
    I18n.locale = receiver.language
    @originator = originator
    @receiver = receiver
    @comment = comment
    @art = art
    puts "Mail to: #{@receiver.email} - Subject: '#{t('mail.comment_on_art.subject', :originator_name => originator.name, :art_name => art.name)}'"
    mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.comment_on_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
  
  def user_publish_art(originator, receiver, art)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    @art = art
    puts "Mail to: #{@receiver.email} - Subject: '#{t('mail.user_publish_art.subject', :originator_name => originator.name, :art_name => art.name)}'"
    mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.user_publish_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
  
  def user_follows_user(originator, receiver)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    puts "Mail to: #{@receiver.email} - Subject: #{t('mail.user_follows_user.subject', :originator_name => originator.name)}"
    mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.user_follows_user.subject', :originator_name => originator.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
  
  def user_likes_art(originator, receiver, art)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    @art = art
    puts "Mail to: #{@receiver.email} - Subject: '#{t('mail.user_likes_art.subject', :originator_name => originator.name, :art_name => art.name)}'"
    mail(:to => "#{@receiver.name} <#{@receiver.email}>", :subject => t('mail.user_likes_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
end
