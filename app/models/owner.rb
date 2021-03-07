# frozen_string_literal: true

class Owner < ApplicationRecord
  validates_uniqueness_of :phone
  validates_presence_of :category, :name

  has_many :houses

  enum category: {
    independent: 'Independent',
    real_state: 'Real state'
  }
end
