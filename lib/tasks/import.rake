desc "import sample data"
task :import => :environment do

  puts "Start importing data"
  	#create data service type
		ServiceType.create!({name: "machine", unit_value: 0.06, description: "$/hour"})
		ServiceType.create!({name: "operating system", unit_value: 0.06, description: "$/hour"})
		ServiceType.create!({name: "storage", unit_value: 0.02, description: "$/GB/hour"})
		ServiceType.create!({name: "data_transfer", unit_value: 0.02, description: "$/GB/hour"})
		#add machine ratio
		VmType.find_by(name: "'SMALL VM'").update_attributes!({ratio: 1})
		VmType.find_by(name: "'MEDIUM VM'").update_attributes!({ratio: 2})
		VmType.find_by(name: "'LARGE VM'").update_attributes!({ratio: 4})
		VmType.find_by(name: "'XTREME VM'").update_attributes!({ratio: 8})
		#add iso ratio
		Iso.find_by(iso_name: "CentOS_5_MPI").update_attributes!({ratio: 1})
		Iso.find_by(iso_name: "CentOS_5_Hadoop").update_attributes!({ratio: 1.5})
		#add shift time
		Shift.create!({shift_type: "red shift", description: "", from: "13:00:00", to: "20:00:00"})
		Shift.create!({shift_type: "blue shift", description: "", from: "07:00:00", to: "12:00:00"})
  puts "Done!"
end