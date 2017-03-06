class Production < ApplicationRecord
  has_many :people
  has_many :scenes

  def characters
    people.map(&:characters).flatten
  end
end
