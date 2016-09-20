# Controller for the {Survey}s.
# Allows us to list the surveys ({#index}), create new surveys
# ({#new}/{#create}), and to update them ({#login}/{#edit}/{#update} )
# the non-CRUD action {#login} is there to put in a login screen when
# the user tries to edit a {Survey} to ensure they have the right to do so.
class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :login]

  # GET /surveys
  #
  # Lists all {Survey}s in two lists :
  # - ongoing (end_date not yet passed)
  # - done    (end_date passed)
  def index
    @surveys_current = Survey.where('end_date > ?', Time.now)
    @surveys_finished = Survey.where('end_date < ?', Time.now)
  end

  # +GET /surveys/:id+
  #
  # Displays the {Survey}'s info : a list of questions + the answer statistics.
  def show
  end

  # +GET /surveys/new+
  #
  # Displays a form with the possibility to add {Question}s
  # and subsequent {Choice}s for said {Question}s. (Nested forms)
  def new
    @survey = Survey.new
  end

  # +POST /surveys+
  #
  # Creates a {Survey} with associated {Question}s and {Choice}s.
  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      redirect_to @survey, notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  # +GET /surveys/:id/login+
  #
  # Allows us to screen the users trying to edit the form.
  # Displays a form with a single field : password that will
  # then be sent to the {#edit} action.
  def login
  end

  # +GET /surveys/:id/edit+
  #
  # +POST /surveys/:id/edit+
  #
  # Displays the edition form if the user went through the {#login} process first
  # and filled in the password correctly, else redirects to {#login} again.
  #
  # The POST route is there to work properly when going through {#login} first.
  def edit
    if params[:login] && # Ensure +params[:login]+ is present.
       params[:login][:password] == @survey.password
      # Setting an in-page proof user logged in.
      @orig_password = @survey.password
      render :edit
    else
      # Back to {#login} if the password is wrong.
      redirect_to login_survey_path(@survey), notice: 'Please login before editing survey.'
    end
  end

  # +PATCH/PUT /surveys/:id+
  #
  # Allows update to a {Survey} if the right password was provided during {#login}.
  def update
    # Boils down to :
    # "if the user went through login with right password before editing:
    #   proceed with update
    #  else:
    #   let them log in again"
    if params[:survey] &&         # Ensures +params[:survey]+ is present.
       params[:survey][:login] && # Ensures +params[:survey][:login]+ is present.
       params[:survey][:login][:orig_password] == @survey.password
      actual_update
    else
      redirect_to login_survey_path(@login), notice: 'Please provide correct password before updating survey.'
    end
  end

  private

  # Before each action that is related to a specific {Survey}
  # (every single one except {#index} ), fetches the {Survey}
  # corresponding to the +:id+ found in the URL and puts it in
  # the +@survey+ variable.
  def set_survey
    @survey = Survey.find(params[:id])
  end

  # Makes sure the parameters we get from forms and others only
  # contain data we actually want.
  # Also allows the nested attributes of {Question}s and of the
  # {Choice}s nested inside said {Question}s.
  def survey_params
    params.require(:survey)
          .permit(
            :title, :end_date, :password, :description,
            questions_attributes: [
              :id, :content, :position,
              choices_attributes: [
                :id, :content
              ]
            ]
          )
  end

  # Code for the actual updating of the {Survey}. Extracted from {#update}
  # action to unclutter it - readability purposes.
  def actual_update
    if @survey.update(survey_params)
      redirect_to @survey, notice: 'Survey was successfully updated.'
    else
      render :edit
    end
  end
end
