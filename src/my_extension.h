#ifndef MY_EXTENSION_H
#define MY_EXTENSION_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/core/binder_common.hpp>

using namespace godot;

class MyExtension : public Node {
	GDCLASS(MyExtension, Node)

protected:
	static void _bind_methods();

public:
	MyExtension();
	~MyExtension();

	// Example methods
	void say_hello();
	int add_numbers(int a, int b);
	String get_extension_info();
};

#endif // MY_EXTENSION_H
