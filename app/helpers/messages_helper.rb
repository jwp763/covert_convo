module MessagesHelper
  def recipients_options(is_random)
    if is_random
      @random_user = current_user.random_interested_user
      s = ''
      s << "<option value='#{@random_user.id}'>#{@random_user.username}</option>"
      s.html_safe
    else
      s = ''
      current_user.friends.each do |user|
        s << "<option value='#{user.id}'>#{user.username}</option>"
      end
      s.html_safe
    end
  end
end
