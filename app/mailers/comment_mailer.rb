class CommentMailer < ActionMailer::Base
  default :from => "admin@ontherailsagain.com", :to => "nim.izadi@gmail.com"
  
  def new_comment(comment)  
    @comment = comment
    mail(:subject => "Vous avez un nouveau commentaire !")
  end  

end
