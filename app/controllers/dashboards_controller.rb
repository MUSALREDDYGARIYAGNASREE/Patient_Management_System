class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def doctor
    # Patients per day
    @patients_chart_data = Patient.group("DATE(created_at)").count

    # Appointments per day
    @appointments_chart_data = Appointment.group(:date).count

    # Age distribution
    @age_distribution = {
      "0-18" => Patient.where(age: 0..18).count,
      "19-35" => Patient.where(age: 19..35).count,
      "36-50" => Patient.where(age: 36..50).count,
      "51+" => Patient.where("age > 50").count
    }
  end

  def receptionist
    @total_patients = Patient.count
    @todays_appointments = Appointment.where(date: Date.today).count
  end

end
