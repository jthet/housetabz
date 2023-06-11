class HousesController < ApplicationController
   def show
    @user = current_user
   end
   
    def new
        @house = House.new
    end

    def create

    end

    def join

    end
end
