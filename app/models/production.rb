require 'digest'

class Production < ApplicationRecord
  has_many :people
  has_many :scenes

  after_create :generate_ios_code!

  def characters
    people.map(&:characters).flatten
  end

  def generate_ios_code!
    self.ios_expiration = 7.days.from_now
    self.ios_code = code_from_string(self.title + self.ios_expiration.to_s)
    save!
  end

  private

  def code_from_string(str)
    md5 = Digest::MD5.new
    md5.hexdigest(str).gsub(/[^\d]/, '')[0..3]
  end
end
