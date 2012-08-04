class Movie < ActiveRecord::Base

  def self.all_ratings
    ["G", "PG", "PG-13", "R"]
  end

  def self.filtered_ratings(ratings)
    if ratings
      ratings.keys
    else
      []
    end
  end
end
