class MicropostsController < ApplicationController
	before_filter :require_login, only: [:create, :destroy]

  def create
  end

  def destroy
  end
end
