class UserMailer < ActionMailer::Base
  default :from => 'faraon.ua@gmail.com'

  def share_task(recipient)
=begin
        @body = "#{} has shared task with you, please follow"
    mail(:to => recipient.email_address_with_name,
         :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"],
         :subject => "Here is what we look like")
=end
  end
end
