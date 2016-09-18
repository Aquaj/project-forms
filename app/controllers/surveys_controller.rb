class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :login]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys_current = Survey.where("end_date > ?", Time.now)
    @surveys_finished = Survey.where("end_date < ?", Time.now)
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      redirect_to @survey, notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    if params[:survey] && params[:survey][:login] && params[:survey][:login][:orig_password] == @survey.password
      if @survey.update(survey_params)
        redirect_to @survey, notice: 'Survey was successfully updated.'
      else
        render :edit
      end
    else
      render :login
    end
  end

  def edit
    if params[:login] && params[:login][:password] == @survey.password
      @orig_password = @survey.password
      render :edit
    else
      render :login
    end
  end

  def login
  end
  # DELETE /surveys/1
  # DELETE /surveys/1.json
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:title, :end_date, :password, :description, questions_attributes: [:id, :content, :position, choices_attributes: [:content, :id]])
    end
end
