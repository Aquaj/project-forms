# Class representing a {Question}, part of a {Survey}.
class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :content, presence: true
  validates :position, presence: true, numericality: { greater_than: 0 }, uniqueness: { scope: :survey_id }

  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true
end
