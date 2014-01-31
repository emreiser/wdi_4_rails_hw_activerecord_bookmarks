class BookmarksController < ApplicationController
	before_action :find_bookmark, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!, only: [:edit, :destroy]


	def find_bookmark
		@bookmark = Bookmark.find(params[:id])
	end

	def index
		@bookmark = Bookmark.new
		@all_bookmarks = Bookmark.all.order(:name)
	end

	def show
		@bookmark.increment! :click_count
	end

	def create
		@bookmark = Bookmark.new(bookmark_params)
		@all_bookmarks = Bookmark.all.order(:name)

		if @bookmark.save
			flash[:notice] = 'Bookmark saved'
			redirect_to root_path
		else
			flash.now[:error] = @bookmark.errors.full_messages.join(', ')
			render :index
		end
	end

	def edit
	end

	def update
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