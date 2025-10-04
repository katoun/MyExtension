#include "firebase_app_options_resource.hpp"
#include "firebase_app_options.hpp"

using namespace godot;

void FirebaseAppOptionsResource::_bind_methods() {
    // Properties
    ClassDB::bind_method(D_METHOD("get_app_id"), &FirebaseAppOptionsResource::get_app_id);
    ClassDB::bind_method(D_METHOD("set_app_id", "value"), &FirebaseAppOptionsResource::set_app_id);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "app_id"), "set_app_id", "get_app_id");

    ClassDB::bind_method(D_METHOD("get_api_key"), &FirebaseAppOptionsResource::get_api_key);
    ClassDB::bind_method(D_METHOD("set_api_key", "value"), &FirebaseAppOptionsResource::set_api_key);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "api_key"), "set_api_key", "get_api_key");

    ClassDB::bind_method(D_METHOD("get_project_id"), &FirebaseAppOptionsResource::get_project_id);
    ClassDB::bind_method(D_METHOD("set_project_id", "value"), &FirebaseAppOptionsResource::set_project_id);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "project_id"), "set_project_id", "get_project_id");

    ClassDB::bind_method(D_METHOD("get_storage_bucket"), &FirebaseAppOptionsResource::get_storage_bucket);
    ClassDB::bind_method(D_METHOD("set_storage_bucket", "value"), &FirebaseAppOptionsResource::set_storage_bucket);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "storage_bucket"), "set_storage_bucket", "get_storage_bucket");

    ClassDB::bind_method(D_METHOD("get_messaging_sender_id"), &FirebaseAppOptionsResource::get_messaging_sender_id);
    ClassDB::bind_method(D_METHOD("set_messaging_sender_id", "value"), &FirebaseAppOptionsResource::set_messaging_sender_id);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "messaging_sender_id"), "set_messaging_sender_id", "get_messaging_sender_id");

    ClassDB::bind_method(D_METHOD("get_auth_domain"), &FirebaseAppOptionsResource::get_auth_domain);
    ClassDB::bind_method(D_METHOD("set_auth_domain", "value"), &FirebaseAppOptionsResource::set_auth_domain);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "auth_domain"), "set_auth_domain", "get_auth_domain");

    ClassDB::bind_method(D_METHOD("get_database_url"), &FirebaseAppOptionsResource::get_database_url);
    ClassDB::bind_method(D_METHOD("set_database_url", "value"), &FirebaseAppOptionsResource::set_database_url);
    ADD_PROPERTY(PropertyInfo(Variant::STRING, "database_url"), "set_database_url", "get_database_url");

    ClassDB::bind_method(D_METHOD("get_enable_analytics"), &FirebaseAppOptionsResource::get_enable_analytics);
    ClassDB::bind_method(D_METHOD("set_enable_analytics", "value"), &FirebaseAppOptionsResource::set_enable_analytics);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_analytics"), "set_enable_analytics", "get_enable_analytics");

    ClassDB::bind_method(D_METHOD("get_enable_auth"), &FirebaseAppOptionsResource::get_enable_auth);
    ClassDB::bind_method(D_METHOD("set_enable_auth", "value"), &FirebaseAppOptionsResource::set_enable_auth);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_auth"), "set_enable_auth", "get_enable_auth");

    ClassDB::bind_method(D_METHOD("get_enable_database"), &FirebaseAppOptionsResource::get_enable_database);
    ClassDB::bind_method(D_METHOD("set_enable_database", "value"), &FirebaseAppOptionsResource::set_enable_database);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_database"), "set_enable_database", "get_enable_database");

    ClassDB::bind_method(D_METHOD("get_enable_storage"), &FirebaseAppOptionsResource::get_enable_storage);
    ClassDB::bind_method(D_METHOD("set_enable_storage", "value"), &FirebaseAppOptionsResource::set_enable_storage);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_storage"), "set_enable_storage", "get_enable_storage");

    ClassDB::bind_method(D_METHOD("get_enable_messaging"), &FirebaseAppOptionsResource::get_enable_messaging);
    ClassDB::bind_method(D_METHOD("set_enable_messaging", "value"), &FirebaseAppOptionsResource::set_enable_messaging);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_messaging"), "set_enable_messaging", "get_enable_messaging");

    ClassDB::bind_method(D_METHOD("get_enable_remote_config"), &FirebaseAppOptionsResource::get_enable_remote_config);
    ClassDB::bind_method(D_METHOD("set_enable_remote_config", "value"), &FirebaseAppOptionsResource::set_enable_remote_config);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_remote_config"), "set_enable_remote_config", "get_enable_remote_config");

    ClassDB::bind_method(D_METHOD("get_enable_firestore"), &FirebaseAppOptionsResource::get_enable_firestore);
    ClassDB::bind_method(D_METHOD("set_enable_firestore", "value"), &FirebaseAppOptionsResource::set_enable_firestore);
    ADD_PROPERTY(PropertyInfo(Variant::BOOL, "enable_firestore"), "set_enable_firestore", "get_enable_firestore");

    // Utility methods
    ClassDB::bind_method(D_METHOD("set_defaults"), &FirebaseAppOptionsResource::set_defaults);
    ClassDB::bind_method(D_METHOD("is_valid"), &FirebaseAppOptionsResource::is_valid);
    ClassDB::bind_method(D_METHOD("to_string"), &FirebaseAppOptionsResource::to_string);
    ClassDB::bind_method(D_METHOD("to_firebase_app_options"), &FirebaseAppOptionsResource::to_firebase_app_options);
}

FirebaseAppOptionsResource::FirebaseAppOptionsResource() {
    set_defaults();
}

FirebaseAppOptionsResource::~FirebaseAppOptionsResource() {
    // Destructor
}

// Getters
String FirebaseAppOptionsResource::get_app_id() const {
    return app_id;
}

String FirebaseAppOptionsResource::get_api_key() const {
    return api_key;
}

String FirebaseAppOptionsResource::get_project_id() const {
    return project_id;
}

String FirebaseAppOptionsResource::get_storage_bucket() const {
    return storage_bucket;
}

String FirebaseAppOptionsResource::get_messaging_sender_id() const {
    return messaging_sender_id;
}

String FirebaseAppOptionsResource::get_auth_domain() const {
    return auth_domain;
}

String FirebaseAppOptionsResource::get_database_url() const {
    return database_url;
}

bool FirebaseAppOptionsResource::get_enable_analytics() const {
    return enable_analytics;
}

bool FirebaseAppOptionsResource::get_enable_auth() const {
    return enable_auth;
}

bool FirebaseAppOptionsResource::get_enable_database() const {
    return enable_database;
}

bool FirebaseAppOptionsResource::get_enable_storage() const {
    return enable_storage;
}

bool FirebaseAppOptionsResource::get_enable_messaging() const {
    return enable_messaging;
}

bool FirebaseAppOptionsResource::get_enable_remote_config() const {
    return enable_remote_config;
}

bool FirebaseAppOptionsResource::get_enable_firestore() const {
    return enable_firestore;
}

// Setters
void FirebaseAppOptionsResource::set_app_id(const String& value) {
    app_id = value;
}

void FirebaseAppOptionsResource::set_api_key(const String& value) {
    api_key = value;
}

void FirebaseAppOptionsResource::set_project_id(const String& value) {
    project_id = value;
}

void FirebaseAppOptionsResource::set_storage_bucket(const String& value) {
    storage_bucket = value;
}

void FirebaseAppOptionsResource::set_messaging_sender_id(const String& value) {
    messaging_sender_id = value;
}

void FirebaseAppOptionsResource::set_auth_domain(const String& value) {
    auth_domain = value;
}

void FirebaseAppOptionsResource::set_database_url(const String& value) {
    database_url = value;
}

void FirebaseAppOptionsResource::set_enable_analytics(bool value) {
    enable_analytics = value;
}

void FirebaseAppOptionsResource::set_enable_auth(bool value) {
    enable_auth = value;
}

void FirebaseAppOptionsResource::set_enable_database(bool value) {
    enable_database = value;
}

void FirebaseAppOptionsResource::set_enable_storage(bool value) {
    enable_storage = value;
}

void FirebaseAppOptionsResource::set_enable_messaging(bool value) {
    enable_messaging = value;
}

void FirebaseAppOptionsResource::set_enable_remote_config(bool value) {
    enable_remote_config = value;
}

void FirebaseAppOptionsResource::set_enable_firestore(bool value) {
    enable_firestore = value;
}

// Utility methods
void FirebaseAppOptionsResource::set_defaults() {
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

bool FirebaseAppOptionsResource::is_valid() const {
    return !project_id.is_empty() && !app_id.is_empty() && !api_key.is_empty();
}

String FirebaseAppOptionsResource::to_string() const {
    return "FirebaseAppOptionsResource{project_id='" + project_id + "', app_id='" + app_id + "', api_key='" + api_key + "', storage_bucket='" + storage_bucket + "'}";
}

Ref<FirebaseAppOptions> FirebaseAppOptionsResource::to_firebase_app_options() const {
    Ref<FirebaseAppOptions> options;
    options.instantiate();
    
    options->set_app_id(app_id);
    options->set_api_key(api_key);
    options->set_project_id(project_id);
    options->set_storage_bucket(storage_bucket);
    options->set_messaging_sender_id(messaging_sender_id);
    options->set_auth_domain(auth_domain);
    options->set_database_url(database_url);
    options->set_enable_analytics(enable_analytics);
    options->set_enable_auth(enable_auth);
    options->set_enable_database(enable_database);
    options->set_enable_storage(enable_storage);
    options->set_enable_messaging(enable_messaging);
    options->set_enable_remote_config(enable_remote_config);
    options->set_enable_firestore(enable_firestore);
    
    return options;
}
