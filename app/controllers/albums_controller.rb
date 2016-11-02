class AlbumsController < ApplicationController
	#method below absolutely necessary to use find_album when necessary
	before_action :find_album, only: [:show, :edit, :update, :destroy]

	def index
		#order albums by decsending order based on creation date
		@albums = Album.all.order("created_at DESC")
	end

	def new
		@album = Album.new
	end

	def create
		@album = Album.new(album_params)
		if @album.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
	end

	def edit
		#actual edit view stuff
	end

	def update
		if @album.update(album_params)
			redirect_to album_path(@album)
		else
			redirect_to 'edit'
		end
	end

	def destroy
		@album.destroy
		redirect_to root_path
	end
	
	private

		def album_params
			params.require(:album).permit(:title, :artist, :description)
		end

		def find_album
			@album = Album.find(params[:id])
		end
end
