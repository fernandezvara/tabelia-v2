class NotifierMailer < ActionMailer::Base
  default from: "Tabelia <antonio@cosmeticanatural.com>"
  
  def comment_on_user(originator, receiver, comment)
    I18n.locale = receiver.language
    @originator = originator
    @receiver = receiver
    @comment = comment
    mail(:to => "#{@receiver.name} <antoniofernandezvara@gmail.com>", :subject => t('mail.comment_on_profile.subject', :originator_name => originator.name)) do |format|
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
    mail(:to => "#{@receiver.name} <antoniofernandezvara@gmail.com>", :subject => t('mail.comment_on_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
  
  def user_publish_art(originator, receiver, art)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    @art = art
    mail(:to => "#{@receiver.name} <antoniofernandezvara@gmail.com>", :subject => t('mail.user_publish_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
  
  def user_follows_user(originator, receiver)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    mail(:to => "#{@receiver.name} <antoniofernandezvara@gmail.com>", :subject => t('mail.user_follows_user.subject', :originator_name => originator.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
  
  def user_likes_art(originator, receiver, art)
    I18n.locale = receiver.language
    @receiver = receiver
    @originator = originator
    @art = art
    mail(:to => "#{@receiver.name} <antoniofernandezvara@gmail.com>", :subject => t('mail.user_likes_art.subject', :originator_name => originator.name, :art_name => art.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
  
end
