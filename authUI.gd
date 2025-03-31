extends Control

onready var email_input = $EmailInput
onready var password_input = $PasswordInput
onready var login_button = $LoginButton
onready var signup_button = $SignupButton
onready var logout_button = $LogoutButton

onready var auth = $HTTPRequest

func _ready():
	if auth.load_user_data():
		print("User already logged in:", auth.user_id)
	else:
		print("No previous login found.")

func _on_LoginButton_pressed():
	var email = email_input.text
	var password = password_input.text
	if auth.log_in(email, password):
		print("Logged in as:", auth.user_id)

func _on_SignupButton_pressed():
	var email = email_input.text
	var password = password_input.text
	if auth.sign_up(email, password):
		print("Account created:", auth.user_id)

func _on_LogoutButton_pressed():
	auth.log_out()
	print("Logged out!")

func _on_TestSaveButton_pressed():
	auth.save()
	print("Saved!")

func _on_TestLoadButton_pressed():
	auth.fetch_user_data_from_firebase()
