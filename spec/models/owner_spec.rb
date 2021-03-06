# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Owner, type: :model do
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:name) }

  it { should have_many(:houses) }
end
