class AlbumsController < ApplicationController
	#method below absolutely necessary to use find_album when necessary
	before_action :find_album, only: [:show, :edit, :update, :destroy]

	def index
		#order albums by decsending order based on creation date
		if params[:genre].blank?
			@albums = Album.all.order("created_at DESC")
		else
			#grabs id of category being passed by genre selection
			@genre_id = Genre.find_by(name: params[:genre]).id
			#load books matching selected genre id
			@albums = Album.where(:genre_id => @genre_id).order("created_at DESC")
		end
	end

	def new
		#now have to create albums based on the current user params
		@album = current_user.albums.build
		#2d array matching all genre types to their ids
		@genres = Genre.all.map{ |c| [c.name, c.id] }
	end

	def create
		@album = current_user.albums.build(album_params)
		#needed to place genre id as part of album build params. as well as populate the genres link list items
		@album.genre_id = params[:genre_id]
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
		#need below line to make sure edit page has access to genre
		@genres = Genre.all.map{ |c| [c.name, c.id] }
	end

	def update
		#update now has access to genres to populate form
		@genres = Genre.all.map{ |c| [ c.name, c.id ] }
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
			params.require(:album).permit(:title, :artist, :description, :genre_id)
		end

		def find_album
			@album = Album.find(params[:id])
		end
end
