extends Node

const FIREBASE_API_KEY = "AIzaSyDKhjWjsuT3HFy93JGcMhklLZjl8cHVbf4"
const FIREBASE_SIGNUP_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
const FIREBASE_LOGIN_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="
const FIREBASE_ANONYMOUS_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
const FIREBASE_URL : String = "https://skull-fighter-default-rtdb.asia-southeast1.firebasedatabase.app/"  # Replace with your Firebase URL

var user_token = ""  # Stores the Firebase ID token
var user_id = ""     # Stores the Firebase User ID

var http_request
	
func ready():		
	load_user_data()
	
func save():
	save_user_data()
	
# Callback for the HTTP request
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("User data saved successfully!")
	else:
		print("Failed to save user data. Response code:", response_code)

func save_user_data_locally(data):
	var file = File.new()
	file.open("user://auth.json", File.WRITE)
	file.store_string(JSON.print(data))
	file.close()

func save_user_data():
	# Prepare the data to be saved
	var data = {
		"user_id": user_id,
		"user_token": user_token,
		"data":{
			"attribute1": 1,
			"attribute2": true,
			"attribute3": "fc",
		}
	}
	
	http_request = HTTPRequest.new()
	self.add_child(http_request)
	http_request.connect("request_completed", self, "_on_request_completed")
	
	save_user_data_locally(data)
		
	var url = FIREBASE_URL + "/users/" + user_id + ".json?auth=" + FIREBASE_API_KEY
	var json_data = JSON.print(data)  # Convert the data to a JSON string
	var headers = ["Content-Type: application/json"]
	
	# Send the data to Firebase using a PUT request
	http_request.request(url, headers, true, 3, json_data)

func _on_fetch_user_data_completed(result: int, response_code: int, headers: Array, body: PoolByteArray):
	var response_string = body.get_string_from_utf8()
	var parsed_response = JSON.parse(response_string)

	if parsed_response.error != OK:
		print("Error parsing JSON response:", parsed_response.error_string)
		return
	
	var result_data = parsed_response.result
	print("Loaded User Data from Firebase:", result_data)

	if result_data:
		# Update user attributes from Firebase
		if "data" in result_data:
			var data = result_data["data"]
			print("Fetched data: ", data)

			# Example of updating local variables
			# (Adjust these according to your game's data structure)
			var attribute1 = data.get("attribute1", 0)
			var attribute2 = data.get("attribute2", false)
			var attribute3 = data.get("attribute3", "")

			# Debug print to verify
			print("Loaded attributes: ", attribute1, attribute2, attribute3)
			
func fetch_user_data_from_firebase():
	if user_id == "":
		print("No user logged in, cannot fetch data.")
		return
	
	var url = FIREBASE_URL + "/users/" + user_id + ".json?auth=" + user_token
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_on_fetch_user_data_completed")

	var error = http_request.request(url, ["Content-Type: application/json"], true, HTTPClient.METHOD_GET)
	if error != OK:
		print("HTTPRequest.request error code: ", error)
		return	

func load_user_data():
	# First, check if we have local authentication info
	var file = File.new()
	if file.file_exists("user://auth.json"):
		file.open("user://auth.json", File.READ)
		var data = JSON.parse(file.get_as_text()).result
		file.close()

		if "user_id" in data and "user_token" in data:
			user_id = data["user_id"]
			user_token = data["user_token"]
			print("Auto-Login: Welcome back, User ID:", user_id)
			
			# Now fetch the actual progress from Firebase
			fetch_user_data_from_firebase()
			return true
	return false
	
# Called when the request is completed. The response is passed in the body as a PoolByteArray.
func _on_signing_request_completed(result: int, response_code: int, headers: Array, body: PoolByteArray):
	# Convert the PoolByteArray to a UTF-8 string
	var response_string = body.get_string_from_utf8()
	
	# Parse the JSON response string
	var parsed_response = JSON.parse(response_string)

	if parsed_response.error != OK:
		print("Error parsing JSON response:", parsed_response.error_string)
		return false

	var result_data = parsed_response.result
	print(result_data)

	if "idToken" in result_data:
		user_token = result_data["idToken"]
		user_id = result_data["localId"]
		print("Login/Sign-up successful:", user_id)
		return true

	print("Login/Sign-up failed:", result_data)
	return false

# Sign-up function
func sign_up(username: String, password: String):
	var url = FIREBASE_SIGNUP_URL + FIREBASE_API_KEY
	var data = {
		"email": username + "@skullfighters.com",
		"password": password,
		"returnSecureToken": true
	}
	var json_data = JSON.print(data)  # Convert dictionary to JSON string

	var http_request = HTTPRequest.new()
	add_child(http_request)  # Add to scene tree

	# Connect the request_completed signal to the handler
	http_request.connect("request_completed", self, "_on_signing_request_completed")

	var error = http_request.request(
		url,
		["Content-Type: application/json"],
		true,
		HTTPClient.METHOD_POST,
		json_data
	)

	if error != OK:
		print("HTTPRequest.request error code: ", error)
		return

# Login function
func log_in(username: String, password: String):
	var url = FIREBASE_LOGIN_URL + FIREBASE_API_KEY
	var data = {
		"email": username + "@skullfighters.com",
		"password": password,
		"returnSecureToken": true
	}
	var json_data = JSON.print(data)  # Convert dictionary to JSON string

	var http_request = HTTPRequest.new()
	add_child(http_request)  # Add to scene tree

	# Connect the request_completed signal to the handler
	http_request.connect("request_completed", self, "_on_signing_request_completed")

	var error = http_request.request(
		url,
		["Content-Type: application/json"],
		true,
		HTTPClient.METHOD_POST,
		json_data
	)

	if error != OK:
		print("HTTPRequest.request error code: ", error)
		return
	
func anonymous_login():
	var url = FIREBASE_ANONYMOUS_URL + FIREBASE_API_KEY
	var data = { "returnSecureToken": true }
	var json_data = JSON.stringify(data)

	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request(url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, json_data, 0)

	yield(http_request, "request_completed")
	var response = JSON.parse(http_request.get_body()).result

	if "idToken" in response:
		user_token = response["idToken"]
		user_id = response["localId"]
		save_user_data()
		print("Anonymous Login Successful! User ID:", user_id)
		return true
	print("Anonymous Login Failed:", response)
	return false
	
func remove_user_data():
	pass
	
func log_out():
	# Clear user token and other session-related data
	user_token = ""
	user_id = ""

	# You can also remove any saved data if needed
	# Example: clear saved user data from file
	remove_user_data()
	
	var file = Directory.new()
	if file.file_exists("user://auth.json"):
		file.remove("user://auth.json")

	print("User logged out successfully")
