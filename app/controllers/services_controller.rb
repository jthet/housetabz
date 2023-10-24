# frozen_string_literal: true

# app/controllers/services_controller.rb

class ServicesController < ApplicationController
  # Action to display the City of Austin Utilities form
  def city_of_austin_utilities
    @city_of_austin_utilities_service = CityOfAustinUtilitiesService.new
  end

  def create_city_of_austin_utilities_service
    @city_of_austin_utilities_service = CityOfAustinUtilitiesService.new(city_of_austin_utilities_params)

    if @city_of_austin_utilities_service.save
      flash[:success] = 'Your service has been successfully added.'
      redirect_to user_house_path(current_user, current_user.house) # Redirect to the main house page
    else
      flash[:error] = 'Failed to add the service.'
      render :city_of_austin_utilities
    end
  end

  def city_of_austin_utilities_params
    params.require(:city_of_austin_utilities_service).permit(:account_number, :house_id)
  end

  # Action to display the Texas Gas form
  def texas_gas
    @texas_gas_service = TexasGasService.new
  end

  # Action to create Texas Gas service
  def create_texas_gas_service
    @texas_gas_service = TexasGasService.new(texas_gas_params)

    if @texas_gas_service.save
      flash[:success] = 'Your service has been successfully added.'
      redirect_to user_house_path(current_user, current_user.house) # Redirect to the main house page
    else
      flash[:error] = 'Failed to add the service.'
      render :city_of_austin_utilities
    end
  end

  # Action to display the Wifi form
  def wifi
    @wifi_service = WifiService.new(network_name: '')
  end

  # Action to create Wifi service
  def create_wifi_service
    @wifi_service = WifiService.new(wifi_params)

    if @wifi_service.save
      flash[:success] = 'Your service has been successfully added.'
      redirect_to user_house_path(current_user, current_user.house)
    else
      flash[:error] = 'Failed to add the service.'
      render :city_of_austin_utilities
    end
  end

  private

  # Strong parameters for Texas Gas form
  def texas_gas_params
    params.require(:texas_gas_service).permit(:account_number, :other_attributes)
  end

  # Strong parameters for Wifi form
  def wifi_params
    params.require(:wifi_service).permit(:network_name, :other_attributes)
  end
end
