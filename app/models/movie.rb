class Movie < ActiveRecord::Base

  def self.all_ratings
    ["G", "PG", "PG-13", "R"]
  end

  def self.filtered_ratings(ratings)
    if ratings
      ratings.keys
    else
      ["G", "PG", "PG-13", "R"] #will need to delete this and make it [] at the end.
    end
  end
end
