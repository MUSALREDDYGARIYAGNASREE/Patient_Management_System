class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_receptionist
  before_action :set_patient, only: %i[show edit update destroy]

  # GET /patients
  def index
    @patients = Patient.all

    if params[:query].present?
      @patients = @patients.where("name ILIKE ?", "%#{params[:query]}%")
    end

    if params[:min_age].present? && params[:max_age].present?
      @patients = @patients.where(age: params[:min_age]..params[:max_age])
    end
  end


  # GET /patients/1
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params)
    @patient.registered_on = Date.today

    if @patient.save
      redirect_to @patient, notice: "Patient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: "Patient was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
    redirect_to patients_path, notice: "Patient was successfully destroyed.", status: :see_other
  end

  private

    def set_patient
      @patient = Patient.find(params[:id])
    end

    def patient_params
      params.require(:patient).permit(:name, :age, :phone, :address, :registered_on)
    end

    def ensure_receptionist
      unless current_user.role == "receptionist"
        redirect_to root_path, alert: "Access denied. Receptionists only."
      end
    end
end
