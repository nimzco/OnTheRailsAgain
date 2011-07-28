class MailerObserver < ActiveRecord::Observer
  observe :comment
 
  def after_create(model)

  end
end