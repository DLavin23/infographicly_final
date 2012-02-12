class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  # will show list of users
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/welcomeback
  # GET /users/1.json
  # goes to login form
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  # login form is directed to this method
  def login
    @user = User.find_by_user_name params[:user_name]
    session[:current_user_id] = @user.id
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'User was successfully created.'}
      format.json { render json: @user }
    end
  end
  
  # directed here for logout
  def logout
    reset_session
    redirect_to new_user_url
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.save
    session[:current_user_id] = @user.id
    redirect_to articles_url
  end
 
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.articles.each do |article|
      article.destroy
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  # GET /users/1/edit
  # def edit
  #     @user = User.find(params[:id])
  #   end
  # PUT /users/1
  # PUT /users/1.json
  # def update
  #     @user = User.find(params[:id])
  # 
  #     respond_to do |format|
  #       if @user.update_attributes(params[:user])
  #         format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #         format.json { head :no_content }
  #       else
  #         format.html { render action: "edit" }
  #         format.json { render json: @user.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   end
end
