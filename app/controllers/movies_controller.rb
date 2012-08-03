class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sort_by]
      @movies = Movie.order("#{params[:sort_by]} ASC").all
      @sort_by = params[:sort_by]
    else 
      @movies = Movie.all
    end
#    if params[:sort_order] == "title"
#      @movies = Movie.order("title ASC").all
#      @sorted_by_title = "hilite"
#    elsif params[:sort_order] == "release_date"
#      @movies = Movie.order("release_date ASC").all
#      @sorted_by_release_date = "hilite"
#    else
#      @movies = Movie.all
#    end
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
