# frozen_string_literal: true

class Item
  include Searchable

  extend Forwardable
  def_delegators :@item, :[]=, :each, :detect

  @collection = []

  def initialize(item = {})
    @item = item
  end

  def self.from(source)
    items = JSON.parse(File.read(source), object_class: Item)
    @collection = Array(items)
    self
  end

  def self.filtered_by(criteria)
    filter_collection(@collection, criteria)
  end
end
