require 'base64'
require 'logger'
class UsersController < ApplicationController
  before_action :find_user
  include HTTParty

  def index
    return render json: {} unless @user
    refresh_token_if_expired
    render json: @user.as_json
  end

  def show
    # @user = User.find(params[:id])
  end

  def location
    return render json: {} unless @user
    refresh_token_if_expired
    headers = { Authorization: 'Bearer ' + @user.token }
    # Route: /characters/<characterID:characterIdType>/location/
    response = HTTParty.get("https://crest-tq.eveonline.com/characters/#{@user.characterID}/location/", headers: headers)
    data = JSON.parse(response.body)
    render json: data
  end

  private

  def find_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def refresh_token_if_expired
    # have to just reset session for now because refresh_token doesn't seem to work
    return unless @user.token_expired?
    reset_session
    @user.delete
    raise ActiveRecord::RecordInvalid
    # my_logger = ::Logger.new 'log/httparty.log'
    # headers = { 'Authorization': 'Basic ' + Base64.encode64("#{ENV['CREST_CLIENT_ID']}:#{ENV['CREST_CLIENT_SECRET']}"), 'Content-Type': 'application/x-www-form-urlencoded' }
    # body = { grant_type: 'refresh_token', refresh_token: @user.refreshToken }
    # response = HTTParty.post('https://login.eveonline.com/oauth/token', body: body.as_json, headers: headers.as_json, logger: my_logger)
    # data = JSON.parse(response.body)
    # @user.update(token: data['token'], expiry: DateTime.now + data['expires_at'].to_i.seconds)
  rescue ActiveRecord::RecordInvalid
    return render json: { error: 'Your user was logged out because refresh_token is not working, please log in again.' }, status: :bad_request
  end
end
