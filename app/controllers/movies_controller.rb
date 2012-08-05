class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
#    session.clear
    unless params[:commit] || session[:ratings].nil?
      flash.keep
      redirect_to movies_path({ ratings: session[:ratings], sort_by: session[:sort_by] }) unless params[:ratings] || params[:sort_by]
    end
    @all_ratings = Movie.all_ratings
    @filtered_ratings = Movie.filtered_ratings(params[:ratings])
    if params[:sort_by]
      @movies = Movie.where({ :rating => @filtered_ratings }).order("#{params[:sort_by]} ASC").all
      @sort_by = params[:sort_by]
    else 
      @movies = Movie.where({ :rating => @filtered_ratings })
    end
    session[:ratings] = params[:ratings]
    session[:sort_by] = params[:sort_by]
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
