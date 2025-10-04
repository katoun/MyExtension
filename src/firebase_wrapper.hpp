#pragma once

#include <godot_cpp/classes/object.hpp>
#include <godot_cpp/core/class_db.hpp>
#include "firebase_app_options.hpp"

// Firebase includes (commented out for now to avoid linking issues)
// #include "firebase/app.h"
// #include "firebase/auth.h"
// #include "firebase/database.h"
// #include "firebase/storage.h"

using namespace godot;

class FirebaseWrapper : public Object {
    GDCLASS(FirebaseWrapper, Object)

protected:
    static void _bind_methods();

    // Singleton instance
    static FirebaseWrapper* _singleton;

    // Firebase instances (commented out for now)
    // firebase::App* firebase_app = nullptr;
    // firebase::auth::Auth* firebase_auth = nullptr;
    // firebase::database::Database* firebase_database = nullptr;
    // firebase::storage::Storage* firebase_storage = nullptr;

public:
    // Singleton access
    static FirebaseWrapper* get_singleton();
    FirebaseWrapper();
    ~FirebaseWrapper();

    // Initialization
    bool initialize();
    bool initialize_with_options(const Ref<FirebaseAppOptions>& options);
    void shutdown();

    // Authentication methods
    void sign_in_anonymously();
    void sign_in_with_email(const String& email, const String& password);
    void sign_up_with_email(const String& email, const String& password);
    void sign_out();
    bool is_signed_in() const;
    String get_user_id() const;

    // Database methods
    void set_database_value(const String& path, const Variant& value);
    void get_database_value(const String& path);
    void delete_database_value(const String& path);

    // Signals
    void _on_auth_state_changed();
    void _on_database_value_changed(const String& path, const Variant& value);

    // Callback methods (called from Firebase)
    void on_auth_success(const String& user_id);
    void on_auth_error(const String& error_message);
    void on_database_success(const String& path, const Variant& value);
    void on_database_error(const String& error_message);

private:
    bool is_initialized = false;
    String current_user_id;
};
