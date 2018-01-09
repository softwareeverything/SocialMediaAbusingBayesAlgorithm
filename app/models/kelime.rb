class Kelime < ApplicationRecord
    belongs_to :kelimead
    has_many :kelimeturs
    has_many :turs, through: :kelimeturs
end