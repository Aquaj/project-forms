class SurveyAnswersController < ApplicationController
  before_action :find_survey, only: [:new, :create]
  
  # GET /survey_answers/new
  def new
    @survey_answer = SurveyAnswer.new
    @survey.questions.order(:position).each do |question|
      @survey_answer.answers.new(question: question)
    end
  end

  
  # POST /survey_answers
  # POST /survey_answers.json
  def create
    @survey_answer = @survey.answers.new(survey_answer_params)

    if @survey_answer.save
      redirect_to root_path, notice: 'Survey answer was successfully created.'
    else
      render :new
    end
  
  end

  private
  
  def find_survey 
    @survey = Survey.find(params[:survey_id])
  end

  def survey_answer_params
    params.require(:survey_answer).permit(:survey_id, answers_attributes:[:id, :choice_id, :question_id])
  end
end