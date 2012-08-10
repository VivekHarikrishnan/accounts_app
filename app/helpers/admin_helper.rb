module AdminHelper

  def sign_in(admin)
    self.current_member = admin
  end

  def current_member=(admin)    
    @current_member = admin
  end

  def current_member
    @current_member ||= Member.find_by_id(session[:member_id])
  end

  def signed_in?
    !@current_member.nil?
  end

  def sign_out
    @current_member = nil    
  end
end
