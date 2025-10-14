# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Journal Creation' do
  describe 'creating a journal' do
    it 'raises NoMethodError when creating via new' do
      expect { ActsAsAccount::Journal.new }.to raise_error(NoMethodError)
    end

    it 'raises NoMethodError when creating via create' do
      expect { ActsAsAccount::Journal.create }.to raise_error(NoMethodError)
    end

    it 'raises NoMethodError when creating via create!' do
      expect { ActsAsAccount::Journal.create! }.to raise_error(NoMethodError)
    end

    it 'successfully creates a journal via current' do
      journal = ActsAsAccount::Journal.current

      expect(journal).to be_a(ActsAsAccount::Journal)
    end
  end
end
