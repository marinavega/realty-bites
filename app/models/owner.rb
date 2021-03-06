# frozen_string_literal: true

class Owner < ApplicationRecord
  validates_uniqueness_of :phone, :email
  validates_presence_of :category, :name

  enum category: {
    independent: 'Independent',
    real_state: 'Real state'
  }
end
