class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_receptionist
  before_action :set_appointment, only: %i[ show edit update destroy ]

  def index
    @appointments = Appointment.includes(:patient).order(date: :desc)
  end

  def show; end

  def new
    @appointment = Appointment.new
  end

  def edit; end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to @appointment, notice: "Appointment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: "Appointment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_url, notice: "Appointment was successfully destroyed.", status: :see_other
  end

  private

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:patient_id, :date, :time, :purpose)
    end

    def ensure_receptionist
      redirect_to root_path, alert: "Access denied. Receptionists only." unless current_user.role == "receptionist"
    end
end
