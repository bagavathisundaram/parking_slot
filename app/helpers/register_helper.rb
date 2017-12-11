module RegisterHelper
	@@slot =[]
	def execute(text)
		temp = text.split(' ')
		case temp[0]
		when "refresh"
			@@slot = []
		when "create_parking_lot"
			@@slot = []
			if (temp[1].present?)
				(1..temp[1].to_i).to_a.each do |index|
					@@slot.push({'slot_no': index,'parked':false})
				end
				return "Created a parking lot with " + temp[1] +" slots"
			else
				return "Create_parking_lot should have one argument"
			end
		when "park"
			return  "No Slots are created" if @@slot ==[]
			@@slot.each do |s|
				if !s[:parked]
					s[:vehicle_number] = temp[1]
					s[:color] = temp[2]
					s[:parked] = true
					return "Allocated slot number:" + s[:slot_no].to_s
				end
			end
			return "Sorry, parking lot is full"
		when "leave"
			return "one argument missing" if temp[1].nil?
			if temp[1].to_i >0 && temp[1].to_i <= @@slot.length
				@@slot[temp[1].to_i-1][:parked] = false
				return "Slot number " + @@slot[temp[1].to_i-1][:slot_no].to_s + " is free"
			else
				content = "Incorrect Slot Number"
			end
		when "status"
			return  "No Slots are created" if @@slot ==[]
			content = ""
			content = content + "\nSlot No.\tRegistration No\tColour\n"
			@@slot.each do |s|
				if s[:parked]
					content = content + s[:slot_no].to_s + "\t\t" + s[:vehicle_number] + "\t" + s[:color]+ "\n"
				end
			end
			return content
		when "registration_numbers_for_cars_with_colour"
			content = "Not found"
			@@slot.each do |s|
				if s[:parked] && s[:color] == temp[1]
					content = content.gsub("Not found","") + s[:vehicle_number] + ","
				end
			end
			return content.chomp(",").gsub(",", ", ")
		when "slot_numbers_for_cars_with_colour"
			content = "Not found"
			@@slot.each do |s|
				if s[:parked] && s[:color] == temp[1]
					content = content.gsub("Not found","") + s[:slot_no].to_s + ","
				end
			end
			return content.chomp(",").gsub(",", ", ")
		when "slot_number_for_registration_number"
			content = "Not found"
			@@slot.each do |s|
				if s[:parked] && s[:vehicle_number] == temp[1]
					content = content.gsub("Not found","") + s[:slot_no].to_s
				end
			end
			return content
		else
			return "Command Not Found"
		end
	end
end

