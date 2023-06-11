class HousesController < ApplicationController
   def show
    @user = current_user
    @house = House.find(params[:id])
    @users = @house.users
   end
   
    def new
        @house = House.new
    end

    def create

    end

    def join

    end
end
