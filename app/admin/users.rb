# frozen_string_literal: true

ActiveAdmin.register User do
  # Columns to display on the index page
  index do
    selectable_column
    id_column
    column :username
    column :email
    column :house
    column :charges
    column :paid_status

    actions
  end

  # Customize the show page
  show do
    attributes_table do
      row :username
      row :email
      row :house
      row :charges
    end
    active_admin_comments
  end

  # Filters for the index page
  filter :username
  filter :email
  filter :house
  filter :charges

  # Delete action
  member_action :destroy, method: :delete do
    user = User.find(params[:id])
    profile = user.profile

    if current_admin_user != user
      # Calculate the sums before destroying associated records
      charges_sum = user.charges.sum(:amount)
      payments_sum = user.payments.sum(:amount)

      # Delete associated charge_payments
      ChargePayment.where(charge_id: user.charges.pluck(:id)).delete_all

      # Destroy associated charges
      user.charges.destroy_all

      # Destroy associated payments
      user.payments.destroy_all

      # Destroy associated balance
      user.balance&.destroy

      # Store user data in deleted_users table
      DeletedUser.create!(
        user_id: user.id,
        username: user.username,
        first_name: profile&.first_name,
        last_name: profile&.last_name,
        charges_sum:,
        payments_sum:,
        balance: user.balance&.amount
      )

      # Destroy the user
      profile&.destroy
      user.destroy

      redirect_to admin_users_path, notice: 'User has been deleted.'
    else
      redirect_to admin_users_path, alert: 'Admin users cannot be deleted.'
    end
  end

  action_item :destroy, only: :show do
    link_to 'Destroy User', destroy_admin_user_path(user),
            method: :delete,
            data: { confirm: 'Are you sure you want to delete this user?' },
            authenticity_token: form_authenticity_token(request.env['HTTP_HOST'])
  end
end
