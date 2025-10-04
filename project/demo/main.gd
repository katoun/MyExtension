extends Control

# Demo script for MyExtension
# This demonstrates how to use the GDExtension

func _ready():
	print("MyExtension Demo loaded")
	
	# Test the extension node
	var my_extension = MyExtension.new()
	add_child(my_extension)
	
	# Call methods from our C++ extension
	my_extension.say_hello()
	
	var result = my_extension.add_numbers(10, 5)
	print("10 + 5 = ", result)
	
	var info = my_extension.get_extension_info()
	print("Extension info: ", info)
	
	# Update the labels to show results
	var labels = $VBoxContainer.get_children()
	if labels.size() >= 4:
		labels[2].text = "Hello GDExtension Node! (Result: " + str(result) + ")"
		labels[3].text = "Extension: " + info
	
	# Clean up
	my_extension.queue_free()
