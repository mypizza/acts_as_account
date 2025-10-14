# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Account Creation' do
  let(:user_a) { create_user('A') }

  describe 'default account' do
    it 'creates a default account for every holder' do
      expect(user_a.account).to be_present
      expect(user_a.account.name).to eq('default')
    end
  end

  describe 'creating accounts with the same name' do
    it 'returns the original account when creating a second account with the same name' do
      original_account = user_a.account
      created_account = ActsAsAccount::Account.create!(holder: user_a, name: 'default')

      expect(created_account).to eq(original_account)
    end
  end

  describe 'creating accounts with different names' do
    it 'allows creating and accessing accounts with different names' do
      default_account = ActsAsAccount::Account.create!(holder: user_a, name: 'default')
      not_default_account = ActsAsAccount::Account.create!(holder: user_a, name: 'not_default')

      expect(user_a.default_account).to be_a(ActsAsAccount::Account)
      expect(user_a.not_default_account).to be_a(ActsAsAccount::Account)
      expect(user_a.default_account).to eq(default_account)
      expect(user_a.not_default_account).to eq(not_default_account)
    end
  end

  describe 'race condition handling' do
    it 'handles race conditions when creating accounts' do
      user = create_user('RaceConditionUser')
      user1 = User.find(user.id)
      user2 = User.find(user.id)

      # Disable the account existence check
      [user1, user2].each do |u|
        u.instance_eval 'def default_account; true; end'
      end

      # Both should be able to call account without errors
      expect { user1.account }.not_to raise_error
      expect { user2.account }.not_to raise_error
    end
  end

  describe 'accounts on a subclass' do
    let(:inheriting_user_a) { create_inheriting_user('A') }

    it 'autocreates an account for inheriting user' do
      account = inheriting_user_a.account

      expect(account).to be_present
      expect(inheriting_user_a.account).to eq(account)
    end
  end
end
