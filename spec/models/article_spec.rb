require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should have_many(:products) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:quantity) }
end
