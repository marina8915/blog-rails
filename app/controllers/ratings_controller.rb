class RatingsController < ApplicationController
  def create
    @post = find_post
    if current_user
      if current_user.access
        if current_user.id != @post.user_id
          check_user ? save_rating : (redirect_to @post, alert: 'You have already voted.')
        else
          redirect_to @post, alert: 'You can not vote for your posts.'
        end
      else
        redirect_to @post, alert: 'Access is denied.'
      end
    else
      redirect_to @post, alert: 'Login or Sign up.'
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

  def save_rating
    params[:rating][:user_id] = current_user.id
    @rating = @post.ratings.create(params.require(:rating).permit(:rating, :user_id))
    if @rating.save
      @post.update_columns(rating: calculate_rating(@post).round(2))
      redirect_to @post
    else
      render 'ratings/_form'
    end
  end

  def calculate_rating(post)
    if post.ratings.present?
      @ratings = post.ratings.inject(0) { |m, k| m + k.rating.to_f } / @post.ratings.size
    else
      @ratings = 0
    end
  end
end
