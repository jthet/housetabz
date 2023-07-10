class HomePageController < ApplicationController
    def index
        if current_user.nil?
          # Display code for new users or users that have not signed in
          # ...
        else
          if current_user.house.nil?
            # Display code for users not associated with any house
            # ...
          else
            # Update user's balance before displaying it
            current_user.balance ||= Balance.create(user: current_user)
            current_user.balance.update(amount: current_user.calculate_balance)
    
            # Render the view
            # ...
          end
        end
      end

      def about

      end
    end