require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passenger saved" do
      get "/passengers"
      must_respond_with :success
    end

    # it "responds with success when there are no passenger" do
    #   get "/passengers"
    #   must_respond_with :not_found
    # end
  end

  describe "show" do
    before do
      @passenger = Passenger.create(name: "Cathy Something")
    end

    it "will get show for valid id" do
      valid_passanger_id = @passenger.id
      get "/passengers/#{valid_passanger_id}"
      must_respond_with :success
    end

    it "will respond with not_found for invalid ids" do
      invalid_passanger_id = 99999999999999
      get "/passengers/#{invalid_passanger_id}"
      must_respond_with :not_found
    end
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
