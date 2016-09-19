# Class representing a survey.
# A Survey is a set of Question s, each of which have Choice s.
class Survey < ActiveRecord::Base
  validates :title, :password, :end_date, presence: true
  has_many :questions, dependent: :destroy
  has_many :answers, class_name: 'SurveyAnswer', dependent: :destroy

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
