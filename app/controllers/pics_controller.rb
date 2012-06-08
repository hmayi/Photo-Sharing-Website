class PicsController < ApplicationController
  def allUsers
    if(session[:user]==nil)
      redirect_to :controller => :user, :action=>:login
    else
      @users = User.all
    end
  end

  def user
    user = User.find(params[:id])
    @userphotos = user.photos
    @usercomments = user.comments
  end

  def comment
    @comment = Comment.new
    if(session[:user]==nil)
      redirect_to :controller => :user, :action=> :login
    else
      @photo=Photo.find(params[:id])
    end
  end

  def post_comment
    if(session[:user]!=nil )
      @photo = Photo.find(params[:id])
      @comment = Comment.new do |c|
        c.photo = @photo
        c.user_id = session[:user]
        c.date_time = DateTime.now
        c.comment = params[:comment][:comment]
      end
      if (@comment.save)
        redirect_to :action=>:allUsers
      else
        render :action => :comment, :id => params[:id]  
      end
      
    else
      render :template => "user/login"
    end
  end

  def photo
  @photo= Photo.new
  end

  def post_photo
    if(params[:photo]!=nil)
    Photo.new do |p|
      p.user_id = session[:user]
      p.date_time = DateTime.now
      p.file_name = params[:photo][:image].original_filename
      p.save
      FileUtils.mv params["photo"]["image"].tempfile, File.join(Rails.root, "app/assets/images", params["photo"]["image"].original_filename)
    redirect_to("/pics/allUsers.html")
     end
    else
      @photo = Photo.new
      render(:action => :photo ,:errors=>'Photo cant be blank')
    end
    
  end

end
