class Api::SessionsController < ApplicationController
  def show
    render body: Digest::SHA1.hexdigest(AIUI.token), status: :ok
  end

  def create
    render json: RunnerAction.new(params), status: :ok
  end
end
