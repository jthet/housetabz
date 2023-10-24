# frozen_string_literal: true

module ApplicationHelper
  def user_initials(user)
    if user.profile
      "#{user.profile.first_name&.chr || 'A'}#{user.profile.last_name&.chr || 'Z'}".upcase
    else
      'AZ'
    end
  end
end
