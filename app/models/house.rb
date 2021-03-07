# frozen_string_literal: true

class House < ApplicationRecord
  validates_uniqueness_of :link
  validates_presence_of :size,
                        :rooms,
                        :bathrooms,
                        :price,
                        :link

  validates_presence_of :size,
                        :rooms,
                        :bathrooms,
                        :price,
                        :link

  belongs_to :owner

  enum category: {
    rent: 'Rent',
    rent_to_own: 'Rent to own',
    sale: 'Sale'
  }
end
