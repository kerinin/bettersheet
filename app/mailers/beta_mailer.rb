class BetaMailer < ActionMailer::Base
  default :from => "BetterSheet <support@bettersheet.com>"
  
  def sign_up(invite)
    mail(:to => invite.email, :subject => "Thanks for registering with BetterSheet!")
  end
  
  def recommend(invite)
    @referrer = invite.referrer
    mail(:to => invite.email, :subject => "#{@referrer} invited you to try out BetterSheet; cost management that's better than spreadsheets")
  end
  
  def notify(invite)
    if invite.referrer.nil?
      mail(:to => 'support@bettersheet.com', :subject => "#{invite.email} signed up for BetterSheet!")
    else
      @referrer = invite.referrer
      mail(:to => 'support@bettersheet.com', :subject => "#{@referrer} just referred #{invite.email} to BetterSheet!")
    end
  end
end
