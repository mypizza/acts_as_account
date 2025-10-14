# frozen_string_literal: true

class User < ActiveRecord::Base
  has_account
  has_account(:not_default)
end

class AbstractUser < ActiveRecord::Base
end

class InheritingUser < AbstractUser
  has_account
end

class Cheque < ActiveRecord::Base
  is_reference
end
