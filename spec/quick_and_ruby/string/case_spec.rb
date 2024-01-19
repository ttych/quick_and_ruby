# frozen_string_literal: true

require 'spec_helper'
require 'quick_and_ruby/string'

RSpec.describe QuickAndRuby::String::Case do
  describe '.snakecase' do
    it 'converts camelCase to snake_case' do
      expect('camelCase'.snakecase).to eq('camel_case')
    end

    it 'converts UPPER CASE to snake_case' do
      expect('JSON'.snakecase).to eq('json')
    end

    it 'converts UPPER_SNAKE_CASE to snake_case' do
      expect('UPPER_SNAKE_CASE'.snakecase).to eq('upper_snake_case')
    end
  end
end
