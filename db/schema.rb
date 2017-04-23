# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170315105632) do

  create_table "bank_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "iban"
    t.string   "bic"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id", using: :btree
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "country_code"
    t.string   "telephone_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "del_customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id"
    t.integer  "delegate_customer_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "equipment", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "serial_number"
    t.datetime "acquisition_date"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "incident"
    t.string   "leasing_reference"
    t.integer  "status"
    t.integer  "equipment_type_id"
    t.integer  "equipment_model_id"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "salesman_id"
    t.index ["equipment_model_id"], name: "index_equipment_on_equipment_model_id", using: :btree
    t.index ["equipment_type_id"], name: "index_equipment_on_equipment_type_id", using: :btree
    t.index ["user_id"], name: "index_equipment_on_user_id", using: :btree
  end

  create_table "equipment_brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "equipment_type_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["equipment_type_id"], name: "index_equipment_brands_on_equipment_type_id", using: :btree
  end

  create_table "equipment_models", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "equipment_brand_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "description",        limit: 65535
    t.integer  "equipment_type_id"
    t.index ["equipment_brand_id"], name: "index_equipment_models_on_equipment_brand_id", using: :btree
  end

  create_table "equipment_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "establishment_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "establishment_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["establishment_id"], name: "index_establishment_services_on_establishment_id", using: :btree
  end

  create_table "establishments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "iban"
    t.string   "bic"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "address",     limit: 65535
    t.integer  "postal_code"
    t.string   "city"
    t.string   "country"
    t.text     "salesman_id", limit: 65535
    t.integer  "plan_id"
    t.index ["plan_id"], name: "index_establishments_on_plan_id", using: :btree
  end

  create_table "form_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "form_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.index ["form_id"], name: "index_form_files_on_form_id", using: :btree
  end

  create_table "form_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "form_id"
    t.integer  "patient_id"
    t.integer  "status",           limit: 3
    t.integer  "users"
    t.integer  "customer_id"
    t.integer  "provider_id"
    t.integer  "supervisor_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "tech_provider_id"
    t.index ["form_id"], name: "index_form_statuses_on_form_id", using: :btree
    t.index ["patient_id"], name: "index_form_statuses_on_patient_id", using: :btree
  end

  create_table "forms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "form_type",           limit: 3
    t.string   "name"
    t.integer  "patient_id"
    t.integer  "users"
    t.integer  "customer_id"
    t.integer  "provider_id"
    t.integer  "supervisor_id"
    t.string   "medical_context"
    t.integer  "status",                        default: 1
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "note"
    t.datetime "payment_pending_at"
    t.datetime "provider_pending_at"
    t.integer  "mail_status",                   default: 24, null: false
    t.integer  "tech_provider_id"
    t.index ["patient_id"], name: "index_forms_on_patient_id", using: :btree
  end

  create_table "insurance_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "insurance_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "ins_file_file_name"
    t.string   "ins_file_content_type"
    t.integer  "ins_file_file_size"
    t.datetime "ins_file_updated_at"
    t.index ["insurance_id"], name: "index_insurance_files_on_insurance_id", using: :btree
  end

  create_table "insurances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "invoice_date"
    t.decimal  "invoice_amount",  precision: 10
    t.integer  "subscription_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["subscription_id"], name: "index_invoices_on_subscription_id", using: :btree
  end

  create_table "invoices_patients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "amount",     limit: 24
    t.integer  "patient_id"
    t.integer  "status"
    t.integer  "form_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",     limit: 65535
    t.text     "redirect_url",    limit: 65535
    t.string   "action"
    t.boolean  "is_read",                       default: false
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.string   "notifiable_type"
    t.integer  "notifiable_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "notifications_recipients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "notification_id"
    t.integer  "recipient_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["notification_id"], name: "index_notifications_recipients_on_notification_id", using: :btree
  end

  create_table "patient_draft_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "gender"
    t.date     "birth_date"
    t.string   "ethenic_group"
    t.string   "social_security_number"
    t.integer  "weight"
    t.integer  "height"
    t.string   "health_insurance"
    t.string   "medical_context"
    t.string   "note"
    t.string   "email"
    t.string   "phone"
    t.string   "password"
    t.string   "patient_agreement"
    t.string   "trusted_person_agreement"
    t.string   "trusted_person_name"
    t.string   "file_type"
    t.bigint   "form_orphan_id"
  end

  create_table "patient_file_draft_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "patient_file_file_name"
    t.string   "patient_file_content_type"
    t.integer  "patient_file_file_size"
    t.datetime "patient_file_updated_at"
    t.integer  "patient_draft_datum_id"
    t.index ["patient_draft_datum_id"], name: "index_patient_file_draft_data_on_patient_draft_datum_id", using: :btree
  end

  create_table "patient_temporary_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "form_orphan_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "upload_file_file_name"
    t.string   "upload_file_content_type"
    t.integer  "upload_file_file_size"
    t.datetime "upload_file_updated_at"
  end

  create_table "patients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "ethenic_group"
    t.integer  "weight",                 limit: 3
    t.integer  "height",                 limit: 3
    t.string   "social_security_number"
    t.integer  "patient_agreement",      limit: 3
    t.string   "trusted_person_name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "health_insurance"
    t.index ["user_id"], name: "index_patients_on_user_id", using: :btree
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "card_number"
    t.date     "expire_on"
    t.decimal  "amount",                         precision: 10
    t.integer  "status"
    t.integer  "form_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.text     "payment_response", limit: 65535
    t.index ["form_id"], name: "index_payments_on_form_id", using: :btree
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "subject_class"
    t.string   "action"
    t.string   "name_en"
    t.text     "description",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name_fr"
    t.string   "title"
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "quota"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.float    "price",       limit: 24
    t.text     "created_by",  limit: 65535
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "position_id"
    t.index ["position_id"], name: "index_positions_users_on_position_id", using: :btree
    t.index ["user_id"], name: "index_positions_users_on_user_id", using: :btree
  end

  create_table "role_permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id", using: :btree
    t.index ["role_id"], name: "index_role_permissions_on_role_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name_en"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "name_fr"
    t.integer  "protected",      limit: 1, default: 0
    t.integer  "custom_role_id"
  end

  create_table "salesmans_postal_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "postal_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_salesmans_postal_codes_on_user_id", using: :btree
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_type"
    t.float    "price",                    limit: 24
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "file_type"
    t.integer  "workflow_type"
    t.integer  "payment_type"
    t.float    "billing_price",            limit: 24
    t.integer  "payment_waiting_delay"
    t.integer  "analysis_delay"
    t.integer  "workflow_delay"
    t.float    "technical_provider_price", limit: 24
    t.integer  "technical_provider_delay"
  end

  create_table "skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name_fr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_en"
  end

  create_table "specialities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name_fr"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.string   "name_en"
  end

  create_table "specialities_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "speciality_id"
    t.index ["speciality_id"], name: "index_specialities_users_on_speciality_id", using: :btree
    t.index ["user_id"], name: "index_specialities_users_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "entity_id"
    t.string   "entity_type"
    t.datetime "subscription_date"
    t.integer  "plan_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["entity_type", "entity_id"], name: "index_subscriptions_on_entity_type_and_entity_id", using: :btree
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  end

  create_table "temp_insurance_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_temp_detail_id"
    t.string   "ins_name"
    t.datetime "ins_end_date"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "operation_status",    default: 0
    t.integer  "insurance_id"
    t.index ["insurance_id"], name: "index_temp_insurance_details_on_insurance_id", using: :btree
  end

  create_table "temp_insurance_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "temp_insurance_detail_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "ins_file_file_name"
    t.string   "ins_file_content_type"
    t.integer  "ins_file_file_size"
    t.datetime "ins_file_updated_at"
    t.integer  "operation_status",         default: 0
    t.integer  "insurance_file_id"
    t.index ["insurance_file_id"], name: "index_temp_insurance_files_on_insurance_file_id", using: :btree
  end

  create_table "temp_skill_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_temp_detail_id"
    t.integer  "skill_id"
    t.string   "comment"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "proof_file_name"
    t.string   "proof_content_type"
    t.integer  "proof_file_size"
    t.datetime "proof_updated_at"
    t.integer  "user_skill_id"
    t.integer  "operation_status",    default: 0
    t.index ["user_skill_id"], name: "index_temp_skill_details_on_user_skill_id", using: :btree
  end

  create_table "user_insurances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "insurance_id"
    t.boolean  "active",       default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["insurance_id"], name: "index_user_insurances_on_insurance_id", using: :btree
    t.index ["user_id"], name: "index_user_insurances_on_user_id", using: :btree
  end

  create_table "user_roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id", using: :btree
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "user_skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.string   "comment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "proof_file_name"
    t.string   "proof_content_type"
    t.integer  "proof_file_size"
    t.datetime "proof_updated_at"
    t.index ["skill_id"], name: "index_user_skills_on_skill_id", using: :btree
    t.index ["user_id"], name: "index_user_skills_on_user_id", using: :btree
  end

  create_table "user_temp_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "speciality_ids",           limit: 65535
    t.integer  "establishment_id"
    t.integer  "establishment_service_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                     default: "",    null: false
    t.string   "encrypted_password",                        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "birth_date"
    t.string   "address"
    t.string   "street"
    t.string   "city"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone"
    t.integer  "status",                                    default: 0
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "authy_id"
    t.datetime "last_sign_in_with_authy"
    t.boolean  "authy_enabled",                             default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "password_changed_at"
    t.integer  "emp_status"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "signature_file_name"
    t.string   "signature_content_type"
    t.integer  "signature_file_size"
    t.datetime "signature_updated_at"
    t.integer  "deleted"
    t.integer  "establishment_id"
    t.integer  "establishment_service_id"
    t.text     "salesman_id",                 limit: 65535
    t.integer  "account_created_user_id"
    t.integer  "account_created_salesman_id"
    t.datetime "deleted_at"
    t.index ["authy_id"], name: "index_users_on_authy_id", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["establishment_id"], name: "index_users_on_establishment_id", using: :btree
    t.index ["establishment_service_id"], name: "index_users_on_establishment_service_id", using: :btree
    t.index ["password_changed_at"], name: "index_users_on_password_changed_at", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bank_accounts", "users"
  add_foreign_key "equipment", "equipment_models"
  add_foreign_key "equipment", "equipment_types"
  add_foreign_key "equipment", "users"
  add_foreign_key "equipment_brands", "equipment_types"
  add_foreign_key "equipment_models", "equipment_brands"
  add_foreign_key "establishment_services", "establishments"
  add_foreign_key "establishments", "plans"
  add_foreign_key "form_files", "forms"
  add_foreign_key "form_statuses", "forms"
  add_foreign_key "form_statuses", "patients"
  add_foreign_key "forms", "patients"
  add_foreign_key "insurance_files", "insurances"
  add_foreign_key "invoices", "subscriptions"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications_recipients", "notifications"
  add_foreign_key "patient_file_draft_data", "patient_draft_data"
  add_foreign_key "payments", "forms"
  add_foreign_key "positions_users", "positions"
  add_foreign_key "positions_users", "users"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "salesmans_postal_codes", "users"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "temp_insurance_details", "insurances"
  add_foreign_key "temp_insurance_files", "insurance_files"
  add_foreign_key "user_insurances", "insurances"
  add_foreign_key "user_insurances", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "user_skills", "skills"
  add_foreign_key "user_skills", "users"
end
