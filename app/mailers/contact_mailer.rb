class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact

    mail(to: 'waltboxwel@gmail.com', subject: 'New Contact Message')
  end
end
