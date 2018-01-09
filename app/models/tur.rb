class Tur < ApplicationRecord
    has_many :kelimeturs
    has_many :kelimes, through: :kelimeturs
end
