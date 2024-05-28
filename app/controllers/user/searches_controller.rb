class User::SearchesController < ApplicationController
    before_action :authenticate_user!
    
    def search
        @range = params[:range]
        @word = params[:word]
        unless @word.present?
          redirect_to request.referer
        end 
        
        if @range == "User"
        @users = User.looks(params[:search], @word).page(params[:page])
        elsif @range == "Post"
        @posts = Post.looks(params[:search], @word).page(params[:page])
        else
        @genres = Genre.looks(params[:search], @word).posts.page(params[:page])
        end
    end 
end
