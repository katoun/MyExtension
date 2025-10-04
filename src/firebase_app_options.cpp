#include "firebase_app_options.hpp"

using namespace godot;

void FirebaseAppOptions::_bind_methods() {
    // Properties
    ClassDB::bind_method(D_METHOD("get_app_id"), &FirebaseAppOptions::get_app_id);
    ClassDB::bind_method(D_METHOD("set_app_id", "value"), &FirebaseAppOptions::set_app_id);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "app_id"), "set_app_id", "get_app_id");

    ClassDB::bind_method(D_METHOD("get_api_key"), &FirebaseAppOptions::get_api_key);
    ClassDB::bind_method(D_METHOD("set_api_key", "value"), &FirebaseAppOptions::set_api_key);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "api_key"), "set_api_key", "get_api_key");

    ClassDB::bind_method(D_METHOD("get_project_id"), &FirebaseAppOptions::get_project_id);
    ClassDB::bind_method(D_METHOD("set_project_id", "value"), &FirebaseAppOptions::set_project_id);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "project_id"), "set_project_id", "get_project_id");

    ClassDB::bind_method(D_METHOD("get_storage_bucket"), &FirebaseAppOptions::get_storage_bucket);
    ClassDB::bind_method(D_METHOD("set_storage_bucket", "value"), &FirebaseAppOptions::set_storage_bucket);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "storage_bucket"), "set_storage_bucket", "get_storage_bucket");

    ClassDB::bind_method(D_METHOD("get_messaging_sender_id"), &FirebaseAppOptions::get_messaging_sender_id);
    ClassDB::bind_method(D_METHOD("set_messaging_sender_id", "value"), &FirebaseAppOptions::set_messaging_sender_id);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "messaging_sender_id"), "set_messaging_sender_id", "get_messaging_sender_id");

    ClassDB::bind_method(D_METHOD("get_auth_domain"), &FirebaseAppOptions::get_auth_domain);
    ClassDB::bind_method(D_METHOD("set_auth_domain", "value"), &FirebaseAppOptions::set_auth_domain);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "auth_domain"), "set_auth_domain", "get_auth_domain");

    ClassDB::bind_method(D_METHOD("get_database_url"), &FirebaseAppOptions::get_database_url);
    ClassDB::bind_method(D_METHOD("set_database_url", "value"), &FirebaseAppOptions::set_database_url);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "database_url"), "set_database_url", "get_database_url");

    ClassDB::bind_method(D_METHOD("get_enable_analytics"), &FirebaseAppOptions::get_enable_analytics);
    ClassDB::bind_method(D_METHOD("set_enable_analytics", "value"), &FirebaseAppOptions::set_enable_analytics);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_analytics"), "set_enable_analytics", "get_enable_analytics");

    ClassDB::bind_method(D_METHOD("get_enable_auth"), &FirebaseAppOptions::get_enable_auth);
    ClassDB::bind_method(D_METHOD("set_enable_auth", "value"), &FirebaseAppOptions::set_enable_auth);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_auth"), "set_enable_auth", "get_enable_auth");

    ClassDB::bind_method(D_METHOD("get_enable_database"), &FirebaseAppOptions::get_enable_database);
    ClassDB::bind_method(D_METHOD("set_enable_database", "value"), &FirebaseAppOptions::set_enable_database);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_database"), "set_enable_database", "get_enable_database");

    ClassDB::bind_method(D_METHOD("get_enable_storage"), &FirebaseAppOptions::get_enable_storage);
    ClassDB::bind_method(D_METHOD("set_enable_storage", "value"), &FirebaseAppOptions::set_enable_storage);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_storage"), "set_enable_storage", "get_enable_storage");

    ClassDB::bind_method(D_METHOD("get_enable_messaging"), &FirebaseAppOptions::get_enable_messaging);
    ClassDB::bind_method(D_METHOD("set_enable_messaging", "value"), &FirebaseAppOptions::set_enable_messaging);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_messaging"), "set_enable_messaging", "get_enable_messaging");

    ClassDB::bind_method(D_METHOD("get_enable_remote_config"), &FirebaseAppOptions::get_enable_remote_config);
    ClassDB::bind_method(D_METHOD("set_enable_remote_config", "value"), &FirebaseAppOptions::set_enable_remote_config);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_remote_config"), "set_enable_remote_config", "get_enable_remote_config");

    ClassDB::bind_method(D_METHOD("get_enable_firestore"), &FirebaseAppOptions::get_enable_firestore);
    ClassDB::bind_method(D_METHOD("set_enable_firestore", "value"), &FirebaseAppOptions::set_enable_firestore);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_firestore"), "set_enable_firestore", "get_enable_firestore");

    // Utility methods
    ClassDB::bind_method(D_METHOD("set_defaults"), &FirebaseAppOptions::set_defaults);
    ClassDB::bind_method(D_METHOD("is_valid"), &FirebaseAppOptions::is_valid);
    ClassDB::bind_method(D_METHOD("to_string"), &FirebaseAppOptions::to_string);
}

FirebaseAppOptions::FirebaseAppOptions() {
    set_defaults();
}

FirebaseAppOptions::~FirebaseAppOptions() {
    // Destructor
}

// Getters
String FirebaseAppOptions::get_app_id() const {
    return app_id;
}

String FirebaseAppOptions::get_api_key() const {
    return api_key;
}

String FirebaseAppOptions::get_project_id() const {
    return project_id;
}

String FirebaseAppOptions::get_storage_bucket() const {
    return storage_bucket;
}

String FirebaseAppOptions::get_messaging_sender_id() const {
    return messaging_sender_id;
}

String FirebaseAppOptions::get_auth_domain() const {
    return auth_domain;
}

String FirebaseAppOptions::get_database_url() const {
    return database_url;
}

bool FirebaseAppOptions::get_enable_analytics() const {
    return enable_analytics;
}

bool FirebaseAppOptions::get_enable_auth() const {
    return enable_auth;
}

bool FirebaseAppOptions::get_enable_database() const {
    return enable_database;
}

bool FirebaseAppOptions::get_enable_storage() const {
    return enable_storage;
}

bool FirebaseAppOptions::get_enable_messaging() const {
    return enable_messaging;
}

bool FirebaseAppOptions::get_enable_remote_config() const {
    return enable_remote_config;
}

bool FirebaseAppOptions::get_enable_firestore() const {
    return enable_firestore;
}

// Setters
void FirebaseAppOptions::set_app_id(const String& value) {
    app_id = value;
}

void FirebaseAppOptions::set_api_key(const String& value) {
    api_key = value;
}

void FirebaseAppOptions::set_project_id(const String& value) {
    project_id = value;
}

void FirebaseAppOptions::set_storage_bucket(const String& value) {
    storage_bucket = value;
}

void FirebaseAppOptions::set_messaging_sender_id(const String& value) {
    messaging_sender_id = value;
}

void FirebaseAppOptions::set_auth_domain(const String& value) {
    auth_domain = value;
}

void FirebaseAppOptions::set_database_url(const String& value) {
    database_url = value;
}

void FirebaseAppOptions::set_enable_analytics(bool value) {
    enable_analytics = value;
}

void FirebaseAppOptions::set_enable_auth(bool value) {
    enable_auth = value;
}

void FirebaseAppOptions::set_enable_database(bool value) {
    enable_database = value;
}

void FirebaseAppOptions::set_enable_storage(bool value) {
    enable_storage = value;
}

void FirebaseAppOptions::set_enable_messaging(bool value) {
    enable_messaging = value;
}

void FirebaseAppOptions::set_enable_remote_config(bool value) {
    enable_remote_config = value;
}

void FirebaseAppOptions::set_enable_firestore(bool value) {
    enable_firestore = value;
}

// Utility methods
void FirebaseAppOptions::set_defaults() {
    app_id = "1:123456789:android:abcdef123456";
    api_key = "AIzaSyDefaultApiKey123456789";
    project_id = "my-firebase-project";
    storage_bucket = "my-firebase-project.appspot.com";
    messaging_sender_id = "123456789";
    auth_domain = "my-firebase-project.firebaseapp.com";
    database_url = "https://my-firebase-project-default-rtdb.firebaseio.com/";
    enable_analytics = true;
    enable_auth = true;
    enable_database = true;
    enable_storage = true;
    enable_messaging = true;
    enable_remote_config = true;
    enable_firestore = true;
}

bool FirebaseAppOptions::is_valid() const {
    return !project_id.is_empty() && !app_id.is_empty() && !api_key.is_empty();
}

String FirebaseAppOptions::to_string() const {
    return "FirebaseAppOptions{project_id='" + project_id + "', app_id='" + app_id + "', api_key='" + api_key + "', storage_bucket='" + storage_bucket + "'}";
}
