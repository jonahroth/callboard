require 'digest'

class Production < ApplicationRecord
  has_many :people
  has_many :scenes
  has_many :works
  has_many :rehearsals
  has_many :schedules

  after_create :generate_ios_code!

  def characters
    people.map(&:characters).flatten
  end

  def generate_ios_code!
    self.ios_expiration = 7.days.from_now
    self.ios_code = code_from_string(Time.zone.now.to_s + " " + self.title)
    self.save!
  end

  private

  def code_from_string(str)
    md5 = Digest::MD5.new
    md5.hexdigest(str + rand(500).to_s).gsub(/[^\d]/, '')[0..3]
  end
end
