class BetaMailer < ActionMailer::Base
  default :from => "BetterSheet <support@bettersheet.com>"
  
  def sign_up(invite)
    mail(:to => invite.email, :subject => "Thanks for registering with BetterSheet!")
    mail(:to => 'support@bettersheet.com', :subject => "#{invite.email} signed up for BetterSheet!")
  end
  
  def recommend(invite)
    @referrer = invite.referrer
    mail(:to => invite.email, :subject => "#{@referrer} invited you to try out BetterSheet; cost management that's better than spreadsheets")
    mail(:to => 'support@bettersheet.com', :subject => "#{referrer} just referred #{invite.email} to BetterSheet!")
  end
end
