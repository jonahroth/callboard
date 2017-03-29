require 'rails_helper'

RSpec.describe Conflict, type: :model do
  it { is_expected.to validate_presence_of(:frequency) }
  it { is_expected.to validate_inclusion_of(:frequency).in_array(%w( O W )) }
end
