require 'rails_helper'

RSpec.describe Production, type: :model do
  subject do
    Production.create!(title: 'Macbeth', ios_code: '1234',
                       ios_expiration: 7.days.from_now)
  end

  context '#generate_ios_code!' do
    it 'gives the production a new four digit code' do
      expect { subject.generate_ios_code! }.to change { subject.reload.ios_code }
    end

    it 'sets an expiration date seven days in the future' do
      subject.generate_ios_code!
      expect(subject.ios_expiration).to be_within(10.seconds).of(7.days.from_now)
    end
  end

end
