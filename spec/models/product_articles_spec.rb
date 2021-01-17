require 'rails_helper'

RSpec.describe ProductArticle, type: :model do
  it { should belong_to(:article) }
  it { should belong_to(:product) }
end
