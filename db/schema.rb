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

ActiveRecord::Schema.define(version: 20180226024524) do

  create_table "analyses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "seq_blood1_data"
    t.string "seq_blood2_data"
    t.string "seq_brain1_data"
    t.string "seq_brain2_data"
    t.string "job_id"
    t.string "status"
    t.string "result_dir"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_analyses_on_project_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "results", force: :cascade do |t|
    t.string "tool"
    t.string "CHROM"
    t.integer "POS"
    t.string "RS_ID"
    t.string "REF"
    t.string "ALT"
    t.string "FORMAT"
    t.decimal "EB"
    t.string "GEN_DP"
    t.string "GEN_AU"
    t.string "GEN_CU"
    t.string "GEN_GU"
    t.string "GEN_TU"
    t.string "GEN_AD"
    t.string "ANN_IMPACT"
    t.string "ANN_GENE"
    t.string "ANN_EFFECT"
    t.string "ANN_HGVS_C"
    t.string "ANN_HGVS_P"
    t.string "dbNSFP_SIFT_pred"
    t.string "dbNSFP_Polyphen2_HDIV_pred"
    t.string "dbNSFP_Polyphen2_HVAR_pred"
    t.string "dbNSFP_MutationTaster_pred"
    t.string "dbNSFP_GERP_NR"
    t.string "dbNSFP_GERP_RS"
    t.decimal "dbNSFP_phastCons100way_vertebrate", precision: 3, scale: 5
    t.decimal "dbNSFP_CADD_phred", precision: 3, scale: 5
    t.integer "dbNSFP_ExAC_AC"
    t.decimal "dbNSFP_ExAC_AF", precision: 3, scale: 5
    t.integer "dbNSFP_ExAC_Adj_AC"
    t.decimal "dbNSFP_ExAC_Adj_AF", precision: 3, scale: 5
    t.integer "dbNSFP_ExAC_EAS_AC"
    t.decimal "dbNSFP_ExAC_EAS_AF", precision: 3, scale: 5
    t.integer "dbNSFP_ExAC_SAS_AC"
    t.decimal "dbNSFP_ExAC_SAS_AF", precision: 3, scale: 5
    t.integer "dbNSFP_ExAC_AFR_AC"
    t.decimal "dbNSFP_ExAC_AFR_AF", precision: 3, scale: 5
    t.integer "dbNSFP_ExAC_AMR_AC"
    t.decimal "dbNSFP_ExAC_AMR_AF", precision: 3, scale: 5
    t.integer "dbNSFP_ExAC_NFE_AC"
    t.decimal "dbNSFP_ExAC_NFE_AF", precision: 3, scale: 5
    t.integer "dbNSFP_ExAC_FIN_AC"
    t.decimal "dbNSFP_ExAC_FIN_AF", precision: 3, scale: 5
    t.integer "analysis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_id"], name: "index_results_on_analysis_id"
  end

  create_table "users", force: :cascade do |t|
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

end
