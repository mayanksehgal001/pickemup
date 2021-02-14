class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true
  self.implicit_order_column = :created_at

  def self.policy_class
    ApplicationPolicy
  end
end
