# frozen_string_literal: true

# app/admin/dashboard.rb

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end

    # Static display of total users, houses, and payments
    columns do
      column do
        panel 'Total Users' do
          h3 class: 'dashboard-link', data: { target: '#total_users_chart' } do
            "Total Users: #{User.count}"
          end
        end
      end

      column do
        panel 'Total Houses' do
          h3 class: 'dashboard-link', data: { target: '#total_houses_chart' } do
            "Total Houses: #{House.count}"
          end
        end
      end

      column do
        panel 'Total Payments' do
          h3 class: 'dashboard-link', data: { target: '#total_payments_chart' } do
            "Total Payments: #{Payment.count}"
          end
        end
      end
    end

    # Placeholder charts
    columns do
      column id: 'total_users_chart' do
        panel 'Total Users Chart' do
          # Your chart implementation goes here (if you decide to implement it)
        end
      end

      column id: 'total_houses_chart' do
        panel 'Total Houses Chart' do
          # Your chart implementation goes here (if you decide to implement it)
        end
      end

      column id: 'total_payments_chart' do
        panel 'Total Payments Chart' do
          # Your chart implementation goes here (if you decide to implement it)
        end
      end
    end
  end
end
