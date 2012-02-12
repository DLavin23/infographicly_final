require 'json'
require 'open-uri'

class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @user = User.find session[:current_user_id]
    list  = JSON.parse(open("https://readitlaterlist.com/v2/get?username=#{@user.user_name}&password=#{@user.password}&apikey=e7ad2l8bTg2d4g4459A4d07Obdg7QKMn").read)["list"]
    @stats = JSON.parse(open("https://readitlaterlist.com/v2/stats?username=#{@user.user_name}&password=#{@user.password}&apikey=e7ad2l8bTg2d4g4459A4d07Obdg7QKMn").read)
    
    Article.parse_json(list, @user.id)
    Article.update_state(list)
    Article.all.each do |article|
      article.source_id = Article.match_source(article.shortlink)
      article.save
    end
    @articles = Article.find_all_by_user_id @user.id
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
end
