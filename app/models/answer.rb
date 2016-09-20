# Class representing the {Answer} to a specific {Survey} {Question},
# linking the {Question} asked with the {Choice} selected.
# Grouped with other {Answer}s through {SurveyAnswer}.
class Answer < ActiveRecord::Base
  belongs_to :survey_answer
  belongs_to :question
  belongs_to :choice
end
