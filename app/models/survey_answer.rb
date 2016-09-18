class SurveyAnswer < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy 
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
