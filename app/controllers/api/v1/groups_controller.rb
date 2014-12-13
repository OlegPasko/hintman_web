# encoding: utf-8
class Api::V1::GroupsController < ApplicationController
  before_action :set_access_control_headers

  def index
    limit = if params[:limit].present?
              params[:limit].to_i
            else
              1000
            end

    groups = if params[:q].present?
               Group.all.where('name ILIKE ?', "#{params[:q]}%").limit(limit)
             else
               Group.all.limit(limit)
            end

    respond_to do |format|
      format.json { render json: { 'groups' => groups }, except: [:created_at, :updated_at] }
    end
  end

  def show
    group = Group.find(params[:id])
    respond_to do |format|
      format.json { render json: group, include: [ :hints => { except: [:created_at, :updated_at, :group_id, :user_id] } ] }
    end
  end
end