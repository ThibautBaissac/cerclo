class HomeController < ApplicationController
  def index
    @categories = Topic.categories
    @topics = Topic.all
  end
end
