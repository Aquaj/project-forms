# Class representing an answer to a Survey, not specific Answer s to Question s
# but rather an user's global Answer.
# Think exam answer sheet ( SurveyAnswer ) vs question answers ( Answer ).
class SurveyAnswer < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
