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
      
        def join
          # Render the view for joining a house
        end
      
        def join_process
          house = House.find_by(name: params[:house_name])
          
          if house && house.authenticate(params[:house_password])
            # Associate the house with the current user
            current_user.update_attribute(:house_id, house.id)
            redirect_to user_house_path(current_user, house), notice: 'You have joined the house successfully.'
          else
            flash.now[:alert] = 'Invalid house name or password.'
            render :join
          end
        end
        
        
        
      
        # ...
      end
      
      def house_options
      end


      private
      
      def house_params
        params.require(:house).permit(:name, :address, :password)
      end
      

