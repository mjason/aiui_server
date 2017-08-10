class Api::SessionsController < ApplicationController
  def show
    token = "a8c63198f2f0b3ad"
    render body: Digest::SHA1.hexdigest(token), status: :ok
  end

  def create
    render json: RunnerAction.new(params), status: :ok
  end
end
