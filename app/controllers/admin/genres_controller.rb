class Admin::GenresController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @genre = Genre.new
        @genres = Genre.all
    end 
    
    def create
        @genre = Genre.new(genre_params)
        @genre.save
        redirect_to request.referer
    end 
    
    def edit 
        @genre = Genre.find(params[:id])
    end 
    
    def update
        @genre = Genre.find(params[:id])
        if @genre.update(genre_params)
           flash[:notice] = "編集に成功しました"
           redirect_to admin_genres_path
        end 
    end 
    
    def destroy
        @genre = Genre.find(params[:id])
        if @genre.destroy
            flash[:notice] = "削除に成功しました"
            redirect_to admin_genres_path
        else 
            flash[:notice] = "削除に失敗しました"
            render :edit
        end 
    end 
    
    private
    
    def genre_params
        params.require(:genre).permit(:name)
    end 
    
end
