class StaticController < ApplicationController
  
  caches_page :about
  
  def about
  end
end
