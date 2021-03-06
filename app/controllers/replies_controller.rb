class RepliesController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.new
    @replies = @tweet.replies
    @user = @tweet.user
    @tweets = @user.tweets
    @followings = @user.followings
    @followers = @user.followers
    @likes = @user.likes
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_replies_path(@tweet)
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.find(params[:id])

    if current_user.admin?
      @reply.destroy
      redirect_to tweet_path(@tweet)
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
