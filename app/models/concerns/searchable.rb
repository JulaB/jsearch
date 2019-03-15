# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  def matches
    @matches ||= []
  end

  def relevancy
    @relevancy ||= 0
  end

  def contains?(phrases)
    return true if phrases.blank?

    @matches = []

    phrases.each do |phrase|
      return false unless matched?(phrase)

      matches << phrase
      self.relevancy += 1
    end

    true
  end

  def excludes?(phrases)
    phrases.none? { |phrase| matched?(phrase) }
  end

  module ClassMethods
    def filter_collection(collection, criteria)
      collection = collection.select do |item|
        item.excludes?(criteria.excluded) && item.contains?(criteria.contained)
      end
      collection.sort_by { |item| -item.relevancy }
    end
  end

  private

  def relevancy=(value)
    @relevancy = value
  end

  def matched?(phrase)
    detect { |_, v| v =~ /#{Regexp.escape(phrase)}/i }.present?
  end
end
