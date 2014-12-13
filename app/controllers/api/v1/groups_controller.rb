# encoding: utf-8
class Api::V1::GroupsController < ApplicationController
  before_action :set_access_control_headers

  def index
    groups = Group.all

    respond_to do |format|
      format.json { render json: { 'groups' => groups }, except: [:created_at, :updated_at] }
    end
  end

  def show
    group = Group.find(params[:id])
    respond_to do |format|
      format.json { render json: group, except: [:created_at, :updated_at], include: [ :hints => { except: [:created_at, :updated_at, :group_id, :user_id] } ] }
    end
  end
end