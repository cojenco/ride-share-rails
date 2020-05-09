class Driver < ApplicationRecord
  has_many :trips

  def avg_rating
    valid_trips = self.trips.where.not(rating: nil)
    total_ratings = valid_trips.map {|trip| trip.rating}
    avg_rating = total_ratings.sum.to_f  / valid_trips.count
    return avg_rating
  end

end
