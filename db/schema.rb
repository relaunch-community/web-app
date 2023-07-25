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

ActiveRecord::Schema[7.0].define(version: 2023_07_24_232942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "investor_firm_roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "professional_profile_id", null: false
    t.uuid "investor_firm_id", null: false
    t.bigint "physical_location_id"
    t.text "title"
    t.text "why_here"
    t.text "investment_target_stage"
    t.text "investment_target_customer"
    t.text "investment_target_industries"
    t.text "investment_target_locations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investor_firm_id"], name: "index_investor_firm_roles_on_investor_firm_id"
    t.index ["physical_location_id"], name: "index_investor_firm_roles_on_physical_location_id"
    t.index ["professional_profile_id"], name: "index_investor_firm_roles_on_professional_profile_id"
  end

  create_table "investor_firms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.text "slug"
    t.text "thesis"
    t.text "overview"
    t.text "site_url"
    t.bigint "physical_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_investor_firms_on_name", unique: true
    t.index ["physical_location_id"], name: "index_investor_firms_on_physical_location_id"
    t.index ["slug"], name: "index_investor_firms_on_slug", unique: true
  end

  create_table "personals_user_profiles", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "hash_id"
    t.text "first_name"
    t.text "last_name"
    t.text "freeform_pronouns"
    t.text "prepopulated_pronouns", null: false
    t.string "headline", limit: 128
    t.string "overview", limit: 1024
    t.text "linkedin_url"
    t.string "email_address", limit: 319, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visibility"
    t.boolean "pronoun_visibility"
    t.index ["email_address"], name: "index_personals_user_profiles_on_email_address", unique: true
    t.index ["hash_id"], name: "index_personals_user_profiles_on_hash_id", unique: true
    t.index ["pronoun_visibility"], name: "index_personals_user_profiles_on_pronoun_visibility"
    t.index ["user_id"], name: "index_personals_user_profiles_on_user_id", unique: true
    t.index ["visibility"], name: "index_personals_user_profiles_on_visibility"
  end

  create_table "physical_locations", force: :cascade do |t|
    t.uuid "hash_id"
    t.text "city"
    t.text "state_subdivision"
    t.text "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hash_id"], name: "index_physical_locations_on_hash_id", unique: true
  end

  create_table "professionals_user_profiles", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hash_id"
    t.index ["hash_id"], name: "index_professionals_user_profiles_on_hash_id", unique: true
    t.index ["user_id"], name: "index_professionals_user_profiles_on_user_id", unique: true
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
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "roles_mask"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["roles_mask"], name: "index_users_on_roles_mask"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.string "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.json "object"
    t.datetime "created_at"
    t.json "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "investor_firm_roles", "investor_firms"
  add_foreign_key "investor_firm_roles", "professionals_user_profiles", column: "professional_profile_id"
  add_foreign_key "personals_user_profiles", "users"
  add_foreign_key "professionals_user_profiles", "users"
end
