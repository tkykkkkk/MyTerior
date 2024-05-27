class User::SearchesController < ApplicationController
    before_action :authenticate_user!
    
    def search
        if @range == "User"
        @users = User.looks(params[:search], params[:word])
        elsif @range == "Post"
        @posts = Post.looks(params[:search], params[:word])
        else 
        @genres = Genre.looks(params[:search], params[:word])
        end
        
        render 'user/searches/search_result'
    end 
    
end
