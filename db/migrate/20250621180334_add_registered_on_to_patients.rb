class AddRegisteredOnToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :registered_on, :date
  end
end
