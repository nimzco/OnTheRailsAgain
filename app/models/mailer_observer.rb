class MailerObserver < ActiveRecord::Observer
  observe :comment
 
  def after_create(comment)
    CommentMailer.new_comment(comment).deliver  
  end
end