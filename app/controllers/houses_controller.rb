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
        @house = House.new(house_params)
        @house.users << current_user
      
        if @house.save
          redirect_to house_path(@house)
        else
          render :new
        end
      end
      
      private
      
      def house_params
        params.require(:house).permit(:name, :address, :password)
      end
      
end
