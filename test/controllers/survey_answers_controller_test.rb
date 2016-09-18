require 'test_helper'

class SurveyAnswersControllerTest < ActionController::TestCase
  setup do
    @survey_answer = survey_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:survey_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey_answer" do
    assert_difference('SurveyAnswer.count') do
      post :create, survey_answer: { survey_id: @survey_answer.survey_id }
    end

    assert_redirected_to survey_answer_path(assigns(:survey_answer))
  end

  test "should show survey_answer" do
    get :show, id: @survey_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survey_answer
    assert_response :success
  end

  test "should update survey_answer" do
    patch :update, id: @survey_answer, survey_answer: { survey_id: @survey_answer.survey_id }
    assert_redirected_to survey_answer_path(assigns(:survey_answer))
  end

  test "should destroy survey_answer" do
    assert_difference('SurveyAnswer.count', -1) do
      delete :destroy, id: @survey_answer
    end

    assert_redirected_to survey_answers_path
  end
end
