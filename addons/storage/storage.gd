extends Node

#Storage Class
class File:
	var data : Dictionary
	var path : String
	var filename : String
	var secret : String
	
	func _init(secretkey, path, open_file):
		self.path = path
		self.filename = open_file
		self.secret = secretkey
		if FileAccess.file_exists(self.path + self.filename):
			self.load_file()
		else:
			create_file(self.filename)
		
		
	func load_file():
		var file : Object = FileAccess.open_encrypted_with_pass(self.path + self.filename, FileAccess.READ, self.secret)
		var json : Object = JSON.new()
		var error = json.parse(file.get_as_text())
		print(file.get_as_text())
		if error == OK:
			var data_received = json.data
			if typeof(data_received) == TYPE_DICTIONARY:
				print(data_received) # Prints array
			else:
				print("Unexpected data")
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", file.get_as_text(), " at line ", json.get_error_line())
		self.data = json.data
		file.close()
		
	func create_file(filename):
		var init_dict : Dictionary
		var file : Object = FileAccess.open_encrypted_with_pass(self.path + self.filename, FileAccess.WRITE, self.secret)
		file.store_string(JSON.stringify(init_dict))
		file.close()
		
	func get_data(key = ""):
		if key == "":
			return self.data
		else:
			return self.data[key]
		
	func set_data(dict):
		for key in dict.keys():
			self.data[key] = dict[key]
		self.write_file()		
		
	func write_file():
		var file : Object = FileAccess.open_encrypted_with_pass(self.path + self.filename, FileAccess.WRITE, self.secret)
		file.store_string(JSON.stringify(self.data))
		file.close()
		
	func delete_data(key):
		self.data.erase(key)
		self.write_file()
		
		

		

