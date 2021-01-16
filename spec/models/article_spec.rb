require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should have_and_belong_to_many(:products) }
end
