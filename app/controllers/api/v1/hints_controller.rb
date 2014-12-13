# encoding: utf-8
class Api::V1::HintsController < ApplicationController
  before_action :set_access_control_headers

  def show
    hint = Hint.find(params[:id])
    respond_to do |format|
      format.json { render json: hint }
    end
  end
end