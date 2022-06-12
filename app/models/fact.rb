class Fact < ApplicationRecord
  validates :fact_text, :likes, :member_id, presence: true
  validates_associated :member
  belongs_to :member
end
