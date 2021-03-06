# frozen_string_literal: true

require 'rails_helper'

RSpec.describe House, type: :model do
  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:rooms) }
  it { should validate_presence_of(:bathrooms) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:link) }

  it { should belong_to(:owner) }
end
