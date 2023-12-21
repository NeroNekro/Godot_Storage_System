extends Node

# Storage Class for handling file operations with encryption
class File:
	var _data : Dictionary # Stores the file data in a dictionary format
	var path : String # Path of the file
	var filename : String # Name of the file
	var secret : String # Secret key used for encryption
	var _encryption : bool # Flag if encryption is set
	
	
	# Constructor for the File class
	# @param path: The path where the file is located or will be created
	# @param open_file: The name of the file to open or create
	# @param secretkey: The encryption key for securing the file, if empty not encryption will set
	func _init(path, open_file, secretkey=""):
		self.path = path
		self.filename = open_file
		if secretkey == "":
			self._encryption == false
			self.secret = secretkey
		else:
			self._encryption == true
			self.secret = secretkey
		if FileAccess.file_exists(self.path + self.filename):
			self.load_file()
		else:
			create_file(self.filename)
		
	# Loads the file from the given path and decrypts it
	func load_file():
		# Open the file with the specified encryption key
		var file : Object
		if _encryption == true:
			file = FileAccess.open_encrypted_with_pass(self.path + self.filename, FileAccess.READ, self.secret)
		else:
			file = FileAccess.open(self.path + self.filename, FileAccess.READ)
		var json : Object = JSON.new()
		var error = json.parse(file.get_as_text())
		print(file.get_as_text())
		if error == OK:
			var data_received = json.data
			# Check if the data type is correct (Dictionary)
			if typeof(data_received) == TYPE_DICTIONARY:
				print(data_received) # Prints array
			else:
				print("Unexpected data")
		else:
			# Handle JSON parsing errors
			print("JSON Parse Error: ", json.get_error_message(), " in ", file.get_as_text(), " at line ", json.get_error_line())
		self._data = json.data
		file.close()
	
	# Creates a new file with the given filename
	func create_file(filename):
		var init_dict : Dictionary
		var file : Object
		if _encryption == true:
			file = FileAccess.open_encrypted_with_pass(self.path + self.filename, FileAccess.WRITE, self.secret)
		else:
			file = FileAccess.open(self.path + self.filename, FileAccess.WRITE)
		file.store_string(JSON.stringify(init_dict))
		file.close()
		
	# Retrieves the data from the file, either all or a specific key
	# @param key: The specific key to retrieve data for, if empty returns all data
	func get_data(key = ""):
		if key == "":
			return self._data
		else:
			return self._data[key]
	
	# Sets the data in the file dictionary and writes it to the file
	# @param dict: The dictionary containing the data to be set
	func set_data(dict):
		for key in dict.keys():
			self._data[key] = dict[key]
		self.write_file()	
		
	# Sets a specific key-value pair in the file's data and updates the file
	# @param key: The key under which the value will be stored
	# @param value: The value to be stored under the specified key
	func set_key(key, value):
		self._data[key] = value
		self.write_file()	
	
	# Writes the current state of the _data dictionary to the file
	func write_file():
		var file : Object
		if _encryption == true:
			file = FileAccess.open_encrypted_with_pass(self.path + self.filename, FileAccess.WRITE, self.secret)
		else:
			file = FileAccess.open(self.path + self.filename, FileAccess.WRITE)
		file.store_string(JSON.stringify(self._data))
		file.close()
		
	# Returns all the data stored in the file
	func get_all_data():
		return self._data
		
	# Deletes a specific key from the file data and updates the file
	# @param key: The key to be deleted from the file data
	func delete_data(key):
		self._data.erase(key)
		self.write_file()

