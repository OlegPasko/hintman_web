# encoding: utf-8
class Api::V1::UsersController < ApplicationController
  before_action :set_access_control_headers

  def create

    user = if User.find_by_device_id(params[:device_id])
             User.find_by_device_id(params[:device_id])
           else
             User.create(device_id: params[:device_id])
           end

    user.generate_auth_token!

    if params[:group_id].present?
      user.update_attributes(group_id: params[:group_id].to_i)
    end

    if user.errors.any?
      respond_to do |format|
        format.json { render json: { errors: user.errors.full_messages }, status: 422 }
      end and return
    end

    respond_to do |format|
      format.json { render json: user, only: [:id, :group_id, :auth_token, :device_id], include: {
                                         group: {
                                             only: [:id, :name], methods: :active_hints
                                         }
                                     }}
    end
  end
end