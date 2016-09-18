class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]


  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
 

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  