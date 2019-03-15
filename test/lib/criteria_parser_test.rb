# frozen_string_literal: true

require 'test_helper'
require 'criteria_parser'
class CriteriaParserTest < ActiveSupport::TestCase
  it 'returns empty list if criteria is empty' do
    assert_equal [], CriteriaParser.new('').excluded
    assert_equal [], CriteriaParser.new('').included
    assert_equal [], CriteriaParser.new('').exact
  end

  describe '#excluded' do
    it 'checks single word' do
      assert_equal %w[word], CriteriaParser.new('-word').excluded
    end

    it 'checks word with minus inside' do
      assert_equal %w[word-sample], CriteriaParser.new('-word-sample').excluded
    end

    it 'checks exact phrase' do
      assert_equal ['word for sample'], CriteriaParser.new('-"word for sample"').excluded
    end

    it 'checks complex phrase' do
      criteria = 'c++ -A++ -C# -word-sample -"word for sample" "exact phrase"'
      expected = ['A++', 'C#', 'word-sample', 'word for sample']
      assert_equal expected, CriteriaParser.new(criteria).excluded
    end
  end

  describe '#exact' do
    it 'checks exact phrase' do
      assert_equal ['exact phrase'], CriteriaParser.new('"exact phrase"').exact
    end

    it 'checks complex phrase' do
      criteria = 'c++ -word-sample "F#" -"word for sample" "exact phrase"'
      expected = ['F#', 'exact phrase']
      assert_equal expected, CriteriaParser.new(criteria).exact
    end
  end

  describe '#included' do
    it 'checks single word with special symbol' do
      assert_equal %w[F#], CriteriaParser.new('F#').included
    end

    it 'checks word with minus inside' do
      assert_equal %w[word-sample], CriteriaParser.new('word-sample').included
    end

    it 'checks complex phrase' do
      criteria = 'c++ -word-sample c# "F#" with-minus -"word sample" "exact phrase"'
      expected = ['c++', 'c#', 'with-minus']
      assert_equal expected, CriteriaParser.new(criteria).included
    end
  end
end
