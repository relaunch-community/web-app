module CurrentWaitlistUser
  private
    def set_waitlist_user
      @waitlist_user = Waitlist::User.find(session.fetch(:waitlist_user, nil))
    rescue ActiveRecord::RecordNotFound
      @waitlist_user = Waitlist::User.new
    end
end