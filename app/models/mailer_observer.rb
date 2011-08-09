class MailerObserver < ActiveRecord::Observer
  observe :comment
 
  def after_create(comment)
    CommentMailer.delay.new_comment(comment)
  end
end