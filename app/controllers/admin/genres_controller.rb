class Admin::GenresController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @genre = Genre.new
        @genres = Genre.all
    end 
    
    def create
        @genres = Genre.all
        @genre = Genre.new(genre_params)
          if @genre.save
            flash[:notice]= "ジャンルの追加に成功しました"
            redirect_to request.referer
          else
            render :index
          end 
    end 
    
    def edit 
        @genre = Genre.find(params[:id])
    end 
    
    def update
        @genre = Genre.find(params[:id])
        if @genre.update(genre_params)
           flash[:notice] = "編集に成功しました"
           redirect_to admin_genres_path
        else 
          flash[:notice] = "編集に失敗しました"
          redirect_to edit_admin_genre_path(@genre.id)
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
