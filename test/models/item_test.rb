# frozen_string_literal: true

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  let(:item) { Item.new(name: 'C++', type: 'Object-oriented class-based') }
  describe 'delegated methods' do
    it 'responds to :each method' do
      assert_respond_to(item, :each)
    end

    it 'responds to :[]= method' do
      assert_respond_to(item, :[]=)
    end

    it 'responds to :detect method' do
      assert_respond_to(item, :detect)
    end
  end

  describe '#relevancy' do
    it 'has default value' do
      assert_equal 0, item.relevancy
    end
  end

  describe '#matches' do
    it 'has default value' do
      assert_equal(item.matches, [])
    end
  end

  describe '#excludes?' do
    it 'returns true if phrases are not given' do
      assert item.excludes?([])
    end

    it 'returns true if item does not contain phrases' do
      assert item.excludes?(['some-word'])
    end

    it 'returns false if item contains phrases' do
      assert_not item.excludes?(['class-based'])
    end
  end

  describe '#contains? method when phrases are not given' do
    it 'returns true' do
      assert item.contains?([])
    end

    it 'cannot change relevancy' do
      assert_no_difference('item.relevancy') do
        item.contains?([])
      end
    end

    it 'cannot change matches' do
      assert_no_difference('item.matches.count') do
        item.contains?([])
      end
    end
  end

  describe '#contains? method then item contains phrases' do
    it 'returns true' do
      assert item.contains?(['class-based'])
    end

    it 'changes relevancy' do
      assert_difference 'item.relevancy', 2 do
        item.contains?(%w[C++ class-based])
      end
    end

    it 'changes change matches' do
      assert_difference 'item.matches.count', 2 do
        item.contains?(%w[C++ class-based])
      end
    end
  end

  describe '#contains? method when item does not contain phrases' do
    it 'returns false' do
      assert_not item.contains?(['some-word'])
    end

    it 'cannot change relevancy' do
      assert_no_difference('item.relevancy') do
        item.contains?(['some-word'])
      end
    end

    it 'cannot change matches' do
      assert_no_difference('item.matches.count') do
        item.contains?(['some-word'])
      end
    end
  end
end
