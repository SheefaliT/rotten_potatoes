# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    # @movies = Movie.all
    @all_ratings = Movie.get_ratings
    # @all_ratings = Movie.get_ratings
    if params[:ratings] == nil and session[:ratings] == nil
      session[:ratings] = @all_ratings
    elsif params[:ratings] != nil
      session[:ratings] = params[:ratings]
    end
    if params[:sort] == nil and session[:sort] == nil
      session[:sort] = "id"
    elsif params[:sort] != nil
      session[:sort] = params[:sort]
    end
    @movies = Movie.where({:rating => session[:ratings].keys}).order(session[:sort]) 
  end

      
        
  #   if params[:sort] == "title"
  #     @movies = Movie.order("title")
  #   end
  #   if params[:sort] == "release_date"
  #     @movies = Movie.order("release_date")
  #   end
  #   if params[:sort] == "rating"
  #     @movies = Movie.order("rating")
  #   end
  #   if params[:ratings] !=nil
  #     session[:ratings] = params[:ratings]
  #   end
  #   # if session[:ratings] != nil
  #     #sorts it by title
  #   end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
