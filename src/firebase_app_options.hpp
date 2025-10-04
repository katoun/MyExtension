#pragma once

#include <godot_cpp/classes/ref_counted.hpp>
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

class FirebaseAppOptions : public RefCounted {
    GDCLASS(FirebaseAppOptions, RefCounted)

protected:
    static void _bind_methods();

private:
    String app_id;
    String api_key;
    String project_id;
    String storage_bucket;
    String messaging_sender_id;
    String auth_domain;
    String database_url;
    bool enable_analytics = true;
    bool enable_auth = true;
    bool enable_database = true;
    bool enable_storage = true;
    bool enable_messaging = true;
    bool enable_remote_config = true;
    bool enable_firestore = true;

public:
    FirebaseAppOptions();
    ~FirebaseAppOptions();

    // Getters
    String get_app_id() const;
    String get_api_key() const;
    String get_project_id() const;
    String get_storage_bucket() const;
    String get_messaging_sender_id() const;
    String get_auth_domain() const;
    String get_database_url() const;
    bool get_enable_analytics() const;
    bool get_enable_auth() const;
    bool get_enable_database() const;
    bool get_enable_storage() const;
    bool get_enable_messaging() const;
    bool get_enable_remote_config() const;
    bool get_enable_firestore() const;

    // Setters
    void set_app_id(const String& value);
    void set_api_key(const String& value);
    void set_project_id(const String& value);
    void set_storage_bucket(const String& value);
    void set_messaging_sender_id(const String& value);
    void set_auth_domain(const String& value);
    void set_database_url(const String& value);
    void set_enable_analytics(bool value);
    void set_enable_auth(bool value);
    void set_enable_database(bool value);
    void set_enable_storage(bool value);
    void set_enable_messaging(bool value);
    void set_enable_remote_config(bool value);
    void set_enable_firestore(bool value);

    // Utility methods
    void set_defaults();
    bool is_valid() const;
    String to_string() const;
};
