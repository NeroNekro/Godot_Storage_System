# 2090s Storage System

## Overview
The File class is a storage utility for handling file operations with optional encryption in Godot Engine. It allows for the creation, reading, writing, updating, and deletion of file contents, with an emphasis on handling JSON-formatted data.

## Features
- **Data Storage**: Stores data in a dictionary format.
- **Encryption**: Optional encryption for file contents using a secret key.
- **Flexible File Handling**: Handles file creation, reading, and writing operations.
- **JSON Format**: Parses and stores data in JSON format.
- **Debug Mode**: A few more information

## Usage

### Initialization
```gdscript
var savegame = Godot_Storage_System.File.new(file_path, open_file, secretkey, debug)
```

- **file_path**: The path where the file is located or will be created.
- **open_file**: The name of the file to open or create.
- **secretkey**: OPTIONAL. The encryption key for securing the file. If empty, no encryption will be set.
- **debug**: OPTIONAL. Standard is false, set to true for more information


### Methods
Sets the data in the file dictionary and writes it to the file. Didnt overwrite the whole dictionary. Existing values are overwritten and new values are added

```gdscript
savegame.set_data(dict)
```

- **dict**: i.e. {"device_id": 1, ...}
- **return**: void


If you want to change a single value without passing a dictionary:
```gdscript
savegame.set_key(key, value)
```

- **key**: i.e. "device_id"
- **value**: i.e. 1
- **return**: void


If you want to get a single value with a specific key:
```gdscript
var data = savegame.get_data(key)
```

- **key**: i.e. "device_id"
- **return**: value or false

If you want to have all data as a dictionary:
```gdscript
var all_data = savegame.get_all_data()
```

- **return**: dictionary


If you want to delete a key:
```gdscript
savegame.delete_data()
```

- **return**: void
