class RatingsController < ApplicationController
  before_action :find_post, only: [:create, :destroy]

  def create
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

  def destroy
    @rating = Rating.find(params[:id])
    if current_user.id == @rating.user_id
      @rating.destroy
      @post.update_columns(rating: calculate_rating(@post).round(2))
      redirect_to @post, notice: 'Mark deleted.'
    else
      redirect_access(@post)
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to @post, alert: 'Mark not found.'
  end

  private

  def find_post
    @post = Post.find(params[:post_id])

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Post not found.'
  end

  def check_user
    @rating = @post.ratings.find_by_user_id(current_user.id)
    if @rating.nil?
      save_rating
    else
      if @rating.rating.to_s == params[:rating][:rating]
        redirect_to @post, notice: 'Mark not changed.'
      else
        @rating.update_columns(rating: params[:rating][:rating])
        @post.update_columns(rating: calculate_rating(@post).round(2))
        redirect_to @post, notice: 'Your mark changed.'
      end
    end
  end

  def save_rating
    params[:rating][:user_id] = current_user.id
    @rating = @post.ratings.create(params.require(:rating).permit(:rating, :user_id))
    if @rating.save
      @post.update_columns(rating: calculate_rating(@post).round(2))
      redirect_to @post, notice: 'Your mark saved.'
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
