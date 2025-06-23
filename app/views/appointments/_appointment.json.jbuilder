json.extract! appointment, :id, :patient_id, :date, :time, :purpose, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
