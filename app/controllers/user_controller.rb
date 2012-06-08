class UserController < ApplicationController
  def login
    @user = User.new
  end
  
def post_login  
   @user=User.find_by_login(params[:user][:login])
     if(@user)
       session[:user] = @user.id
       redirect_to("/pics/allUsers.html") 
     else
       @user = User.new
       flash[:error]="Enter valid user name"
       render(:action => :login)
    end
 end
  
def logout
    session[:user]=nil
    redirect_to(:action=> "login") 
end
def register
  @user=User.new
end
def post_register
  if(session[:user]!=nil)
   
    @user = User.new do |u|
      u.first_name=params[:user][:first_name]
      u.last_name=params[:user][:last_name]
      u.login = (u.last_name).downcase
   
   
    end
     if (@user.save)
       redirect_to :action => :login
     else
       render :template => "user/register"
     end
  end
end
end

