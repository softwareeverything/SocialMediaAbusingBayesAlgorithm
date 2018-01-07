class Kelime < ApplicationRecord
    belongs_to :kelimead
    has_many :kelimeturs
end