class NotifierMailer < ActionMailer::Base
  default from: "Tabelia <antonio@cosmeticanatural.com>"
  
  def comment_on_user(originator, receiver, comment)
    I18n.locale = receiver.locale
    @originator = originator
    @receiver = receiver
    @comment = comment
    mail(:to => "#{@receiver.name} <antoniofernandezvara@gmail.com>", :subject => t('mail.comment_on_profile.subject', :originator_name => originator.name)) do |format|
      format.text
      format.html { render :layout => 'tabeliamail' }
    end
  end
end
