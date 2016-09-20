# Controller for our {SurveyAnswer}s.
# Allows a user to create a {SurveyAnswer} but we don't wish to
# let them edit their answers or delete them.
class SurveyAnswersController < ApplicationController
  before_action :find_survey, only: [:new, :create]

  # +GET /survey/:survey_id/survey_answers/new+
  #
  # Displays a form with nested {Answer} forms.
  def new
    redirect_to surveys_path if @survey.end_date > Time.now # Can't answer if not currently going.
    @survey_answer = SurveyAnswer.new
    @survey.questions.order(:position).each do |question|
      @survey_answer.answers.new(question: question)
    end
  end

  # +POST survey/:survey_id/survey_answers+
  #
  # Creates a {SurveyAnswer} for the {Survey} +:survey_id+
  def create
    @survey_answer = @survey.answers.new(survey_answer_params)

    if @survey_answer.save
      redirect_to root_path, notice: 'Survey answer was successfully created.'
    else
      render :new
    end
  end

  private

  # Since we are in nested routes ({SurveyAnswer} nested in {Survey}), this method
  # sets +@survey+ to the {Survey} object we're currently working with.
  def find_survey
    @survey = Survey.find(params[:survey_id])
  end

  # {SurveyAnswer} params to avoid people sending in unpredictable possibly
  # malicious data through the forms.
  #
  # Includes the {Answer} attributes since we nested the forms.
  def survey_answer_params
    params
      .require(:survey_answer)
      .permit(
        :survey_id,
        answers_attributes:
          [
            :id,
            :choice_id,
            :question_id
          ]
      )
  end
end
