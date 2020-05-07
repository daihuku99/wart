class ExhibitionArt < ApplicationRecord
  belongs_to :exhibition
  belongs_to :art
end
