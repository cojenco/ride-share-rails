require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  before do
    @driver = Driver.new(name: "Lightning Mcqueen", vin: "LMCQ888SPEED888" )
  end

  let (:driver_hash) {
    {
      driver: {
        name: "Speed", 
        vin: "IMSPEEDLMCQ",
      }
    }
  }

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Ensure that there is at least one Driver saved
      @driver.save
      get drivers_path
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Ensure that there are zero drivers saved
      get drivers_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Ensure that there is a driver saved
      @driver.save
      get driver_path(@driver.id)
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Ensure that there is an id that points to no driver
      get driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Ensure that there is a change of 1 in Driver.count
      expect { 
        post drivers_path, params: driver_hash
      }.must_differ "Driver.count", 1

      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      expect(Driver.last.name).must_equal driver_hash[:driver][:name]
      expect(Driver.last.vin).must_equal driver_hash[:driver][:vin]

      # Check that the controller redirected the user
      must_redirect_to driver_path(Driver.last.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      puts "!!!!!!!!!!!!!!!!!!!!!!!!HAVE NOT DONE VALIDATION YET!!!!!!!!!!!!!!!!!"
      # Note: This will not pass until ActiveRecord Validations lesson
      # Set up the form data so that it violates Driver validations

      # Ensure that there is no change in Driver.count

      # Check that the controller redirects
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Ensure there is an existing driver saved
      @driver.save

      get edit_driver_path(@driver.id)
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Ensure there is an invalid id that points to no driver
      get edit_driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Ensure there is an existing driver saved
      @driver.save
      id = Driver.last.id

      expect {
        patch driver_path(id), params: driver_hash
      }.wont_change "Driver.count"

      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      edited_driver = Driver.find(id)
      expect(edited_driver.name).must_equal driver_hash[:driver][:name]
      expect(edited_driver.vin).must_equal driver_hash[:driver][:vin]

      # Check that the controller redirected the user
      must_redirect_to driver_path(id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Ensure there is an invalid id that points to no driver
      expect {
        patch driver_path(-1), params: driver_hash
      }.wont_change "Driver.count"

      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      puts "!!!!!!!!!!!!!!!!!!!!!!!!HAVE NOT DONE VALIDATION YET!!!!!!!!!!!!!!!!!"
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      @driver.save

      expect {
        delete driver_path(@driver.id)
      }.must_differ "Driver.count", -1

      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      @driver.save
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(-1)
      }.wont_change "Driver.count"

      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found
    end
  end
end
