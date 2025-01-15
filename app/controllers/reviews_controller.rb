# class ReviewsController < ApplicationController
#   def create
#     @restaurant = Restaurant.find(params[:restaurant_id])
#     @review = @restaurant.reviews.new(review_params)
#     if @review.save
#       redirect_to restaurant_path(@restaurant)
#     else
#       @reviews = @restaurant.reviews
#       render 'restaurants/show', status: :unprocessable_entity
#     end
#   end

#   private

#   def review_params
#     params.require(:review).permit(:content, :rating)
#   end
# end

class ReviewsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)

    if @review.save
      redirect_to restaurant_path(@restaurant), notice: 'Review was successfully added.'
    else
      @reviews = @restaurant.reviews # Re-fetch the reviews after an invalid submission
      flash.now[:alert] = 'Failed to add review. Please check the form for errors.'
      render 'restaurants/show', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
