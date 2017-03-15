require 'rails_helper'

RSpec.describe Person, type: :model do
  context '#link_to_uuid' do
    it 'changes the uuid' do
      expect { subject.link_to_uuid('abc') }.to change { subject.ios_uuid }.to('abc')
    end
  end
end
