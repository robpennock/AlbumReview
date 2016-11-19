class ReviewsController < ApplicationController

	before_action :find_album
	before_action :find_review, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)

		#need to save with respect to the current book and current user
		@review.album_id = @album.id
		@review.user_id = current_user.id
		#if saving redirect to show page
		if @review.save
			redirect_to album_path(@album)
		else
			render 'new'
		end
	end

	def edit
		#done with before action
	end

	def update
		#review found with before_action
		#redirect to album show if saving
		if @review.update(review_params)
			redirect_to album_path(@album)
		else
			render 'edit'
		end 
	end

	def destroy
		@review.destroy
		redirect_to album_path(@album)
	end

	private

		def review_params
			params.require(:review).permit(:rating, :comment)
		end

		def find_album
			@album = Album.find(params[:album_id])
		end

		def find_review
			@review = Review.find(params[:id])
		end
end
