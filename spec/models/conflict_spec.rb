require 'rails_helper'

RSpec.describe Conflict, type: :model do
  subject do
    described_class.create(
      person: Person.create(first: 'test', last: 'test'),
      start: 1.day.from_now.to_s,
      end: 2.days.from_now.to_s
    )
  end

  it { is_expected.to validate_presence_of(:frequency) }
  it { is_expected.to validate_inclusion_of(:frequency).in_array(%w( O W )) }
end
