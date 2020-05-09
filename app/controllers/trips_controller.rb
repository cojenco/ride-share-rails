class TripsController < ApplicationController

  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit, :bad_request
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to passengers_path
    end
  end

  def new
    passenger_id = params[:passenger_id]
    tips = rand(1..1000).to_f
    @driver = Driver.where(available: true).first
    
    params_hash = {
      passenger_id: passenger_id,
      date: Date.new,
      cost: tips,
      rating: nil,
      driver_id: @driver.id
    }

    @trip = Trip.new(params_hash)
    if @trip.save
      redirect_to trip_path(@trip.id)
      @driver.update(available: false)
      return
    else
      redirect_to passenger_path(passenger_id)
      return
    end
  end


  private
  def trip_params
    return params.require(:trip).permit(:date, :cost, :rating)
  end
end
