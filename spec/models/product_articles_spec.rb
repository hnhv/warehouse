require 'rails_helper'

RSpec.describe ProductArticle, type: :model do
  it { should belong_to(:article) }
  it { should belong_to(:product) }
  it { should validate_presence_of(:quantity) }
end
