extends Control

# Test script for MyExtension
# This scene tests MyNode, MySingleton, and Firebase singleton

func _ready():
	print("=== MyExtension Test Scene Started ===")
	
	# Update status
	$VBoxContainer/StatusLabel.text = "Status: Testing..."
	
	# Test 1: Check if MyNode class is available
	print("Test 1: Checking MyNode class availability...")
	if ClassDB.class_exists("MyNode"):
		print("✓ MyNode class is registered!")
		$VBoxContainer/StatusLabel.text = "Status: MyNode found!"
		
		# Create and test MyNode
		var my_node = MyNode.new()
		add_child(my_node)
		print("✓ MyNode created and added to scene")
		
		# Test MyNode method
		var result = my_node.hello_node()
		print("✓ MyNode.hello_node() returned: ", result)
		$VBoxContainer/TestLabel.text = "MyNode: " + result
	else:
		print("✗ MyNode class not found!")
		$VBoxContainer/StatusLabel.text = "Status: MyNode NOT found!"
		$VBoxContainer/TestLabel.text = "ERROR: MyNode class not available"
		return
	
	# Test 2: Check if MySingleton is available
	print("Test 2: Checking MySingleton availability...")
	if MySingleton:
		print("✓ MySingleton is available!")
		$VBoxContainer/StatusLabel.text = "Status: MyNode and MySingleton working!"
		
		# Test MySingleton method
		MySingleton.hello_singleton($VBoxContainer/TestLabel)
		print("✓ MySingleton.hello_singleton() called successfully")
		print("Final label text: ", $VBoxContainer/TestLabel.text)
	else:
		print("✗ MySingleton not available!")
		$VBoxContainer/StatusLabel.text = "Status: MySingleton NOT found!"
		$VBoxContainer/TestLabel.text += "\nERROR: MySingleton not available"
	
	# Test 3: Check if Firebase singleton is available
	print("Test 3: Checking Firebase singleton availability...")
	if Firebase:
		print("✓ Firebase singleton is available!")
		$VBoxContainer/StatusLabel.text = "Status: All classes working!"
		
		# Test Firebase initialization with default options
		var init_result = Firebase.initialize()
		print("✓ Firebase.initialize() returned: ", init_result)
		
		# Test FirebaseAppOptions class (clean, separated approach)
		print("✓ Testing FirebaseAppOptions class...")
		var options = FirebaseAppOptions.new()
		options.project_id = "my-clean-project"
		options.app_id = "1:555666777:android:xyzabc123456"
		options.api_key = "AIzaSyCleanApiKey123456"
		options.storage_bucket = "my-clean-project.appspot.com"
		options.auth_domain = "my-clean-project.firebaseapp.com"
		options.database_url = "https://my-clean-project-default-rtdb.firebaseio.com/"
		options.enable_analytics = true
		options.enable_auth = true
		options.enable_database = true
		options.enable_storage = true
		options.enable_messaging = true
		options.enable_remote_config = true
		options.enable_firestore = true
		
		# Test FirebaseAppOptions methods
		print("✓ FirebaseAppOptions validation: ", options.is_valid())
		print("✓ FirebaseAppOptions string: ", options.to_string())
		
		# Initialize Firebase with FirebaseAppOptions (clean approach)
		var init_with_options = Firebase.initialize_with_options(options)
		print("✓ Firebase.initialize_with_options(options) returned: ", init_with_options)
		
		# Test Firebase configuration from resource file
		print("✓ Testing Firebase configuration from resource file...")
		var config_resource = load("res://config/firebase_config.tres")
		if config_resource and config_resource is FirebaseAppOptionsResource:
			print("✓ Firebase configuration resource loaded successfully!")
			print("✓ Resource validation: ", config_resource.is_valid())
			print("✓ Resource string: ", config_resource.to_string())
			
			# Convert resource to FirebaseAppOptions and initialize
			var resource_options = config_resource.to_firebase_app_options()
			if resource_options.is_valid():
				var init_from_resource = Firebase.initialize_with_options(resource_options)
				print("✓ Firebase.initialize_with_options(from_resource) returned: ", init_from_resource)
			else:
				print("✗ Invalid Firebase options from resource!")
		else:
			print("✗ Failed to load Firebase configuration resource!")
		
		# Test different environment configurations
		print("✓ Testing environment-specific configurations...")
		var dev_config = load("res://config/firebase_config_dev.tres")
		var prod_config = load("res://config/firebase_config_prod.tres")
		
		if dev_config and dev_config is FirebaseAppOptionsResource:
			print("✓ Development config loaded: ", dev_config.project_id)
		if prod_config and prod_config is FirebaseAppOptionsResource:
			print("✓ Production config loaded: ", prod_config.project_id)
		
		# Test Firebase authentication
		Firebase.sign_in_anonymously()
		print("✓ Firebase.sign_in_anonymously() called")
		
		# Test Firebase database operations
		Firebase.set_database_value("test/path", "test_value")
		print("✓ Firebase.set_database_value() called")
		
		Firebase.get_database_value("test/path")
		print("✓ Firebase.get_database_value() called")
		
		# Check if user is signed in
		var is_signed_in = Firebase.is_signed_in()
		print("✓ Firebase.is_signed_in() returned: ", is_signed_in)
		
		# Get user ID
		var user_id = Firebase.get_user_id()
		print("✓ Firebase.get_user_id() returned: ", user_id)
		
		# Update UI with Firebase status
		$VBoxContainer/TestLabel.text += "\nFirebase: " + str(is_signed_in) + " (" + user_id + ")"
	else:
		print("✗ Firebase singleton not available!")
		$VBoxContainer/StatusLabel.text = "Status: Firebase NOT found!"
		$VBoxContainer/TestLabel.text += "\nERROR: Firebase singleton not available"
	
	print("=== MyExtension Test Complete ===")
	print("Check the scene to see the results!")