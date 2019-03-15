# frozen_string_literal: true

class CriteriaParser
  def initialize(criteria)
    @criteria = criteria
    @phrases = {}
  end

  def excluded
    return [] if @criteria.blank?

    # it matches words that start with '-'. ex: -some-word -"strict phrase"
    @phrases[:excluded] ||= scan(/(?:^|\s)(?:-)([\w+#-]+)|-"([^"]+)"/i)
  end

  def included
    return [] if @criteria.blank?

    # it matches words that do not start with '-' but can include it
    @phrases[:included] ||= scan(/(?:^|\s)(?!-)([\w+#-]+)(?!\S)/i)
  end

  def exact
    return [] if @criteria.blank?

    # it matches "words in double quotes"
    @phrases[:exact] ||= scan(/(?:^|\s)"([^"]+)"/i)
  end

  def contained
    (exact + included).uniq
  end

  private

  def scan(pattern)
    @criteria.scan(pattern).flatten.reject(&:blank?).uniq
  end
end
