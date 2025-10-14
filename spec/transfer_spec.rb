# frozen_string_literal: true

require 'spec_helper'
require 'active_support/core_ext/array/grouping'

RSpec.describe 'Transfer' do
  describe 'transferring money between accounts with holders' do
    let!(:thies) { create_user('Thies') }
    let!(:norman) { create_user('Norman') }

    context 'with positive amount' do
      before do
        transfer_between_users(30, 'Thies', 'Norman')
      end

      it 'debits the from account' do
        expect(user_balance('Thies')).to eq(-30)
      end

      it 'credits the to account' do
        expect(user_balance('Norman')).to eq(30)
      end

      it 'maintains correct posting order (Soll an Haben)' do
        ActsAsAccount::Posting.all.to_a.in_groups_of(2) do |from, to|
          expect(from.amount).to be < 0
          expect(to.amount).to be > 0
        end
      end
    end

    context 'with negative amount' do
      before do
        transfer_between_users(-30, 'Thies', 'Norman')
      end

      it 'credits the from account' do
        expect(user_balance('Thies')).to eq(30)
      end

      it 'debits the to account' do
        expect(user_balance('Norman')).to eq(-30)
      end

      it 'maintains correct posting order (Soll an Haben)' do
        ActsAsAccount::Posting.all.to_a.in_groups_of(2) do |from, to|
          expect(from.amount).to be < 0
          expect(to.amount).to be > 0
        end
      end
    end
  end

  describe 'transferring money between global accounts' do
    before do
      global_account('wirecard')
      global_account('anonymous_donation')
      transfer_between_global_accounts(30, 'wirecard', 'anonymous_donation')
    end

    it 'debits the from account' do
      expect(global_account_balance('wirecard')).to eq(-30)
    end

    it 'credits the to account' do
      expect(global_account_balance('anonymous_donation')).to eq(30)
    end
  end

  describe 'transferring money with a reference object' do
    let!(:thies) { create_user('Thies') }
    let!(:norman) { create_user('Norman') }
    let!(:cheque) { Cheque.create!(number: 8723) }

    before do
      transfer_between_users(50, 'Thies', 'Norman', reference: cheque)
    end

    it 'debits the from account' do
      expect(user_balance('Thies')).to eq(-50)
    end

    it 'credits the to account' do
      expect(user_balance('Norman')).to eq(50)
    end

    it 'associates all postings with the reference' do
      cheque_record = Cheque.where(number: 8723).first

      ActsAsAccount::Posting.all.each do |posting|
        expect(posting.reference).to eq(cheque_record)
      end
    end

    it 'allows the reference to access all postings' do
      cheque_record = Cheque.where(number: 8723).first

      expect(cheque_record.postings).to match_array(ActsAsAccount::Posting.all.to_a)
    end
  end

  describe 'transferring money with a specific booking time' do
    let!(:thies) { create_user('Thies') }
    let!(:norman) { create_user('Norman') }
    let(:valuta) { german_date_time_to_local('22.05.1968', '07:45') }

    before do
      transfer_between_users(50, 'Thies', 'Norman', valuta: valuta)
    end

    it 'debits the from account' do
      expect(user_balance('Thies')).to eq(-50)
    end

    it 'credits the to account' do
      expect(user_balance('Norman')).to eq(50)
    end

    it 'sets the booking time on all postings' do
      expected_valuta = german_date_time_to_local('22.05.1968', '07:45')

      ActsAsAccount::Posting.all.each do |posting|
        expect(posting.valuta).to eq(expected_valuta)
      end
    end
  end
end
