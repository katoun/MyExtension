#include "register_types.h"

#include <gdextension_interface.h>
#include <godot_cpp/classes/engine.hpp>

#include "my_node.hpp"
#include "my_singleton.hpp"
#include "firebase_wrapper.hpp"

using namespace godot;

void gdextension_initialize(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) return;

	ClassDB::register_class<MyNode>();
	ClassDB::register_class<MySingleton>();
	ClassDB::register_class<FirebaseWrapper>();
	
	// Create and register the singletons
	MySingleton *my_singleton = memnew(MySingleton);
	Engine::get_singleton()->register_singleton("MySingleton", my_singleton);
	
	FirebaseWrapper *firebase_singleton = memnew(FirebaseWrapper);
	Engine::get_singleton()->register_singleton("Firebase", firebase_singleton);
}

void gdextension_terminate(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) return;
	
	// Unregister and cleanup Firebase singleton
	Engine::get_singleton()->unregister_singleton("Firebase");
	if (FirebaseWrapper::get_singleton()) {
		memdelete(FirebaseWrapper::get_singleton());
	}
	
	// Unregister and cleanup MySingleton
	Engine::get_singleton()->unregister_singleton("MySingleton");
	if (MySingleton::get_singleton()) {
		memdelete(MySingleton::get_singleton());
	}
}

extern "C"
{
	GDExtensionBool GDE_EXPORT myextension_gdextension_init(GDExtensionInterfaceGetProcAddress p_get_proc_address, const GDExtensionClassLibraryPtr p_library, GDExtensionInitialization *r_initialization)
	{
		godot::GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library, r_initialization);

		init_obj.register_initializer(gdextension_initialize);
		init_obj.register_terminator(gdextension_terminate);
		init_obj.set_minimum_library_initialization_level(MODULE_INITIALIZATION_LEVEL_SCENE);

		return init_obj.init();
	}
}
