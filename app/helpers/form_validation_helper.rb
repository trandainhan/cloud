module FormValidationHelper
	def is_matched(password, password_confirmation)
		password == password_confirmation
	end

	def is_long_enough(password)
		password.to_s.length() >= 8
	end

	def validation( username, password, password_confirmation)
		return {ret: false, detail: "Username is empty"} if username.empty?
		return {ret: false, detail: "Password is empty"} if password.empty?
		return {ret: false, detail: "Password confirmation is empty"} if password_confirmation.empty?
		return {ret: false, detail: "Password is too short"} unless is_long_enough(password)
		return {ret: false, detail: "Password and password confirmation is not matched"} unless is_matched(password, password_confirmation)
		return {ret: true}
	end
end