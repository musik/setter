class HomeController < ApplicationController
  def index
    render text: request.subdomain
  end
  def test
    render :xml=>params
  end
end
