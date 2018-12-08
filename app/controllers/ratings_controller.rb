class RatingsController < ApplicationController
  def create
    @post = find_post
    if current_user && check_user
      params[:rating][:user_id] = current_user.id
      @rating = @post.ratings.create(params.require(:rating).permit(:rating, :user_id))
      if @rating.save
        redirect_to @post
      else
        render 'ratings/_form'
      end
    else
      redirect_to @post
    end
  end

  private

  def check_user
    @post = find_post
    @rating = @post.ratings.find_by_user_id(current_user.id)
    @rating.nil?
  end

  def find_post
    Post.find(params[:post_id])
  end
end
