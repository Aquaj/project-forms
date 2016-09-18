class Answer < ActiveRecord::Base
  belongs_to :survey_answer
  belongs_to :question
  belongs_to :choice
end
