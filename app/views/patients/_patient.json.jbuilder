json.extract! patient, :id, :name, :age, :phone, :address, :created_at, :updated_at
json.url patient_url(patient, format: :json)
