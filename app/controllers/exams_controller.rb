class ExamsController < ApplicationController
  before_action :set_exam, only: %i[ show edit update destroy ]
  before_action :check_session

  # GET /exams or /exams.json
  def index
    @exams = Exam.all
    @exams.map(&:attributes)
  end

  # GET /exams/1 or /exams/1.json
  def show
    @exam = Exam.find(params[:id])
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    @patient = Patient.new
    @patients = Patient.all.map { |p| ["ID: #{p.id} - #{p.name}", p.id] }
    @exam_types = ExamType.all.map { |p| ["ID: #{p.id} - #{p.name}", p.id] }
  end

  # GET /exams/1/edit
  def edit
    @exam = Exam.find(params[:id])
    @patients = Patient.all.map { |p| ["ID: #{p.id} - #{p.name}", p.id] }
    @exam_types = ExamType.all.map { |p| ["ID: #{p.id} - #{p.name}", p.id] }
  end

  # POST /exams or /exams.json
  def create
    @exam = Exam.new(exam_params)
    @exam.patient = Patient.new(exam_params[:patient])
    @exam.exam_type = ExamType.new(exam_params[:exam_type])

    respond_to do |format|
      if @exam.save
        format.html { redirect_to exam_url(@exam), notice: "Exam was successfully created." }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1 or /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to exam_url(@exam), notice: "Exam was successfully updated." }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1 or /exams/1.json
  def destroy
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to exams_url, notice: "Exam was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.require(:exam).permit(
      [
        :id,
        :result,
        :date,
        {
          patient: [
            :id,
            :name,
            :email,
            :cpf
          ]
        },
        {
          exam_type: [
            :id,
            :name
          ]
        }
      ]
    )
  end
end
