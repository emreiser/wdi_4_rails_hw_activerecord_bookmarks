class BookmarksController < ApplicationController

	def index
		@bookmark = Bookmark.new
		@all_bookmarks = Bookmark.all.order(:name)
	end

	def show
		@bookmark = Bookmark.find(params[:id])
	end

	def create
		@bookmark = Bookmark.new(bookmark_params)

		if @bookmark.save
			flash[:notice] = 'Bookmark saved'
			redirect_to root_path
		else
			flash[:error] = @bookmark.errors.full_messages.join(', ')
			redirect_to root_path
		end
	end

	def edit
		@bookmark = Bookmark.find(params[:id])
	end

	def update
		@bookmark = Bookmark.find(params[:id])
		@bookmark.assign_attributes(bookmark_params)
		if @bookmark.save
			flash[:notice] = 'Bookmark updated'
			redirect_to root_path
		else
			flash.now[:error] = @bookmark.errors.full_messages.join(', ')
			render :edit
		end
	end

	def destroy
		@bookmark = Bookmark.find(params[:id])

		if @bookmark.destroy
			flash[:notice] = 'Bookmark deleted'
			redirect_to root_path
		else
			flash.now[:error] = @bookmark.errors.full_messages
			render :back
		end
	end


	private

	def bookmark_params
		params.require(:bookmark).permit(:name, :url, :comment, :favorite)
	end

end