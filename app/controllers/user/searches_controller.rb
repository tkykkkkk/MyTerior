class User::SearchesController < ApplicationController
    before_action :authenticate_user!
    
    def search
        @range = params[:range]
        @word = params[:word]
        
        if @range == "User"
        @users = User.looks(params[:search], @word).page(params[:page])
        else
        @posts = Post.looks(params[:search], @word).page(params[:page])
        end
    end 
end
