# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    source = Rails.root.join('data/data.json')
    criteria = CriteriaParser.new(params[:criteria])
    @items = Item.from(source).filtered_by(criteria)
  end
end
