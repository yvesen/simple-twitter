class UsersController < ApplicationController

  before_action :set_user,only:[:edit, :update, :tweets, :followings, :followers, :likes]

  def tweets
    # @tweets = Tweet.all
    @tweets = @user.tweets
    @followings = @user.followings
    @followers = @user.followers
    @order_user_tweets = @user.tweets.order(created_at: :desc)
    @likes = @user.likes
    
  end

  def edit
    unless @user == current_user
      redirect_to tweets_user_path(@user)      
    end
  end

  def update
    @user.update(user_params)
    redirect_to tweets_user_path(@user)
  end

  def followings
    @followings = @user.followings.order('followships.created_at DESC')
    @tweets = @user.tweets
    @followers = @user.followers
    @likes = @user.likes
    # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers = @user.followers.order('followships.created_at DESC')
    @tweets = @user.tweets
    @followings = @user.followers
    @likes = @user.likes
    # 基於測試規格，必須講定變數名稱
  end

  def likes
    @likes = @user.liked_tweets.order('likes.created_at DESC')
    @tweets = @user.tweets
    @followers = @user.followers
    @followings = @user.followings
    # 基於測試規格，必須講定變數名稱
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
