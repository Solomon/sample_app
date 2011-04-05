class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  
 

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
  	@title = @user.name
  end
  

  def new
    redirect_to(root_path) if signed_in?
  	@user = User.new
  	@title = "Sign up"
  end

  def index
    @title = "All users"
    @users = User.paginate( :page => params[:page])
  end

  def create
    redirect_to(root_path) if signed_in?
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample app!"
  		redirect_to @user
  	else
  		@title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
  		render 'new'
  	end
  end

  def edit
   @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user?(@user)
      flash[:notice] = "You cannot delete yourself"
      redirect_to users_path
    else
      @user.destroy
      flash[:success] = "User destroyed"
      redirect_to users_path
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end




  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      if signed_in?
        redirect_to(root_path) unless current_user.admin?
      else
        redirect_to(signin_path)
      end
    end


end
