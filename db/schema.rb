# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_12_215225) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "diets", ["carnivores", "herbivores"]
  create_enum "power_statuses", ["active", "down"]
  create_enum "specieses", ["tyrannosaurus", "giganotosaurus", "velociraptor", "spinosaurus", "megalosaurus", "yutyrannus", "acrocanthosaurus", "carnotaurus", "deinonychus", "allosaurus", "troodon", "herrerasaurus", "brachiosaurus", "stegosaurus", "ankylosaurus", "triceratops", "diplodocus", "dracorex", "moschops", "argentinosaurus", "edmontosaurus", "hadrosaurus", "nodosaurus"]

  create_table "cages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "tag", null: false
    t.enum "power_status", null: false, enum_type: "power_statuses"
    t.integer "dinosaurs_count", default: 0, null: false
    t.integer "max_capacity", default: 1, null: false
    t.string "location", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["power_status"], name: "index_cages_on_power_status"
    t.index ["tag"], name: "index_cages_on_tag", unique: true
  end

  create_table "dinosaurs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "cage_id"
    t.string "name", null: false
    t.enum "diet", null: false, enum_type: "diets"
    t.enum "species", null: false, enum_type: "specieses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cage_id"], name: "index_dinosaurs_on_cage_id"
    t.index ["name"], name: "index_dinosaurs_on_name", unique: true
    t.index ["species"], name: "index_dinosaurs_on_species"
  end

  create_table "oauth_access_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "resource_owner_type"
    t.uuid "resource_owner_id"
    t.uuid "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_type", "resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dinosaurs", "cages"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
