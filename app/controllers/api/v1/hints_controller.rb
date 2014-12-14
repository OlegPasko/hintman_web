# encoding: utf-8
class Api::V1::HintsController < ApplicationController
  before_action :set_access_control_headers
  before_action :check_token, only: [:vote, :create]

  def show
    hint = Hint.find(params[:id])

    expired, vote_value, voted = voting_data(hint)
    respond_to do |format|
      format.json { render json: hint.as_json(include: { group: { only: [:name] } }).merge(expired: expired, voted: voted, vote_value: vote_value) }
    end
  end

  def create
    if params[:user_id].present? && params[:group_id].present? && params[:content].present?
      hint = Hint.new
      hint.group = Group.find(params[:group_id])
      hint.user = User.find(params[:user_id])
      hint.content = params[:content]
      if hint.save
        expired, vote_value, voted = voting_data(hint)
        respond_to do |format|
          format.json { render json: hint.as_json(include: { group: { only: [:name] } }).merge(expired: expired, voted: voted, vote_value: vote_value) }
        end
      else
        respond_to do |format|
          format.json { render json: {errors: user_vote.errors.full_messages }, status: 422 }
        end
      end


    else
      respond_to do |format|
        format.json { render json: {errors: ['Parameters missing.'] }, status: 422 }
      end
    end
  end

  def vote
    if params[:id].present? && params[:user_id].present? && params[:value].present? && UserVote::VALUES.include?( params[:value] )
      positive = params[:value] == 'up' ? true : false
      hint = Hint.find(params[:id])
      user_vote = UserVote.new(user_id: params[:user_id], positive: positive, hint: hint)
      if user_vote.save

        expired, vote_value, voted = voting_data(hint)

        respond_to do |format|
          format.json { render json: hint.as_json(include: { group: { only: [:name] } }).merge(expired: expired, voted: voted, vote_value: vote_value) }
        end
      else
        respond_to do |format|
          format.json { render json: {errors: user_vote.errors.full_messages }, status: 422 }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {errors: ['Parameters missing.'] }, status: 422 }
      end
    end

  end

  private

  def voting_data(hint)
    expired = hint.created_at < Time.now-1.day ? true : false

    voted = if params[:user_id].present?
              UserVote.where(user_id: params[:user_id].to_i, hint: hint).any? ? true : false
            else
              false
            end

    vote_value = if voted
                   UserVote.where(user_id: params[:user_id].to_i, hint: hint).first.positive ? 'up' : 'down'
                 else
                   false
                 end
    return expired, vote_value, voted
  end

end