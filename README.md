# File Class

## Overview
The File class is a storage utility for handling file operations with optional encryption in Godot Engine. It allows for the creation, reading, writing, updating, and deletion of file contents, with an emphasis on handling JSON-formatted data.

## Features
- **Data Storage**: Stores data in a dictionary format.
- **Encryption**: Optional encryption for file contents using a secret key.
- **Flexible File Handling**: Handles file creation, reading, and writing operations.
- **JSON Format**: Parses and stores data in JSON format.

## Usage

### Initialization
```gdscript
var file = GStorage.File.new(path, open_file, secretkey="")
```

- **path**: The path where the file is located or will be created.
- **open_file**: The name of the file to open or create.
- **secretkey**: The encryption key for securing the file. If left empty, no encryption will be set.
