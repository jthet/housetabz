# frozen_string_literal: true

class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
  end
end
