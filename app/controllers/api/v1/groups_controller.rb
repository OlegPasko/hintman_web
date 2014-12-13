# encoding: utf-8
class Api::V1::GroupsController < ApplicationController
  before_action :set_access_control_headers

  def index
    groups = Group.all

    respond_to do |format|
      format.json { render json: { 'groups' => groups } }
    end
  end
end