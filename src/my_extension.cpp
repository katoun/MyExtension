#include "my_extension.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

using namespace godot;

void MyExtension::_bind_methods() {
	ClassDB::bind_method(D_METHOD("say_hello"), &MyExtension::say_hello);
	ClassDB::bind_method(D_METHOD("add_numbers", "a", "b"), &MyExtension::add_numbers);
	ClassDB::bind_method(D_METHOD("get_extension_info"), &MyExtension::get_extension_info);
}

MyExtension::MyExtension() {
	UtilityFunctions::print("MyExtension: Constructor called");
}

MyExtension::~MyExtension() {
	UtilityFunctions::print("MyExtension: Destructor called");
}

void MyExtension::say_hello() {
	UtilityFunctions::print("MyExtension: Hello from C++!");
}

int MyExtension::add_numbers(int a, int b) {
	return a + b;
}

String MyExtension::get_extension_info() {
	return "MyExtension v1.0 - Built for Godot 4.5";
}
