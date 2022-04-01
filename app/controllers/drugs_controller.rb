class DrugsController < ApplicationController
  before_action :set_drug, only: %i[ show edit update destroy ]
  before_action :check_session

  # GET /drugs or /drugs.json
  def index
    @drugs = Drug.all
  end

  # GET /drugs/1 or /drugs/1.json
  def show
  end

  # GET /drugs/new
  def new
    @drug = Drug.new
  end

  # GET /drugs/1/edit
  def edit
  end

  # POST /drugs or /drugs.json
  def create
    @drug = Drug.new(drug_params)

    respond_to do |format|
      if @drug.save
        format.html { redirect_to drugs_url(@drug), notice: "Drug was successfully created." }
        format.json { render :show, status: :created, location: @drug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drugs/1 or /drugs/1.json
  def update
    respond_to do |format|
      if @drug.update(drug_params)
        format.html { redirect_to drug_url(@drug), notice: "Drug was successfully updated." }
        format.json { render :show, status: :ok, location: @drug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drugs/1 or /drugs/1.json
  def destroy
    @drug.destroy

    respond_to do |format|
      format.html { redirect_to drugs_url, notice: "Drug was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_drug
    @drug = Drug.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def drug_params
    params.require(:drug).permit(:id, :name)
  end
end
