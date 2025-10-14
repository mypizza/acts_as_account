# frozen_string_literal: true

module ActsAsAccountHelpers
  def german_date_time_to_local(datestring, timestring)
    Time.local(*(datestring.split('.').reverse + timestring.split(':')).map(&:to_i))
  end

  def create_user(name)
    User.create!(name: name)
  end

  def create_inheriting_user(name)
    InheritingUser.create!(name: name)
  end

  def find_user_by_name(name)
    User.find_by_name(name)
  end

  def find_inheriting_user_by_name(name)
    InheritingUser.find_by_name(name)
  end

  def user_account(name)
    find_user_by_name(name).account
  end

  def global_account(name)
    ActsAsAccount::Account.for(name)
  end

  def transfer_between_users(amount, from_name, to_name, reference: nil, valuta: nil)
    from_account = user_account(from_name)
    to_account = user_account(to_name)
    ActsAsAccount::Journal.current.transfer(amount, from_account, to_account, reference, valuta)
  end

  def transfer_between_global_accounts(amount, from_name, to_name)
    from_account = global_account(from_name)
    to_account = global_account(to_name)
    ActsAsAccount::Journal.current.transfer(amount, from_account, to_account, nil, nil)
  end

  def user_balance(name)
    user_account(name).postings.sum(:amount)
  end

  def global_account_balance(name)
    global_account(name).postings.sum(:amount)
  end
end

RSpec.configure do |config|
  config.include ActsAsAccountHelpers
end
