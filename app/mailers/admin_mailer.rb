# frozen_string_literal: true

class AdminMailer < ApplicationMailer
  def notifications(adminObj, nSubject)
    admin_email = adminObj.email
    @admin_name = adminObj.show_name
    mail(to: admin_email, subject: nSubject)
  end
end
