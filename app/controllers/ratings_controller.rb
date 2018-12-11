class RatingsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if current_user
      if current_user.access
        if current_user.id != @post.user_id
          check_user
        else
          redirect_to @post, alert: 'You can not vote for your posts.'
        end
      else
        redirect_access(@post)
      end
    else
      redirect_to @post, alert: 'Login or Sign up.'
    end
  end

  private

  def check_user
    if @post.ratings.find_by_user_id(current_user.id).nil?
      save_rating
    else
      redirect_to @post, alert: 'You have already voted.'
    end
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
    @ratings = if post.ratings.present?
                 post.ratings.inject(0) { |sum, mark| sum + mark.rating.to_f } / @post.ratings.size
               else
                 0
               end
  end
end
