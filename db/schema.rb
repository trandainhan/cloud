# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140326065133) do

  create_table "group_users_mapping", id: false, force: true do |t|
    t.integer "group_id",                        null: false
    t.integer "user_id",                         null: false
    t.integer "is_leader", limit: 1, default: 0, null: false
  end

  add_index "group_users_mapping", ["group_id"], name: "fk_group_user_mapping_group_id_idx", using: :btree
  add_index "group_users_mapping", ["user_id"], name: "fk_group_user_mapping_user_id_idx", using: :btree

  create_table "group_vm_requests", force: true do |t|
    t.integer  "user_id",                              null: false
    t.string   "groupname"
    t.integer  "num_vm_request",                       null: false
    t.integer  "vm_type",                              null: false
    t.integer  "need_process",   limit: 1, default: 1, null: false
    t.integer  "is_granted",     limit: 1, default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at"
  end

  add_index "group_vm_requests", ["user_id"], name: "fk_group_vm_requests_user_id_idx", using: :btree
  add_index "group_vm_requests", ["vm_type"], name: "fk_group_vm_requests_vm_type_idx", using: :btree

  create_table "group_vms_mapping", force: true do |t|
    t.integer "group_id", null: false
    t.integer "vm_id",    null: false
  end

  create_table "groups", primary_key: "group_id", force: true do |t|
    t.integer "user_id",                    null: false
    t.string  "group_name",                 null: false
    t.integer "numvms",                     null: false
    t.integer "type_id",    default: 1,     null: false
    t.integer "iso_id",     default: 1,     null: false
    t.boolean "state",      default: false, null: false
  end

  add_index "groups", ["iso_id"], name: "fk_groups_iso_idx", using: :btree
  add_index "groups", ["user_id"], name: "fk_user_id_idx", using: :btree

  create_table "isos", force: true do |t|
    t.string  "iso_name",                    null: false
    t.boolean "is_custom",   default: false, null: false
    t.boolean "is_clonable", default: true,  null: false
    t.boolean "is_single",                   null: false
    t.boolean "is_group",    default: false, null: false
    t.float   "ratio"
  end

  create_table "lease_logs", force: true do |t|
    t.integer  "vm_id",                                  null: false
    t.datetime "start_time"
    t.datetime "stop_time"
    t.integer  "isTerminated",   limit: 1, default: 0,   null: false
    t.float    "run_time"
    t.float    "price_per_hour",           default: 0.0, null: false
    t.float    "total_price"
    t.integer  "iso_id"
  end

  add_index "lease_logs", ["vm_id"], name: "lease_log_vm_id_idx", using: :btree

  create_table "service_types", force: true do |t|
    t.string   "name"
    t.float    "unit_value"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shifts", force: true do |t|
    t.string   "shift_type"
    t.string   "description"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "single_vm_requests", force: true do |t|
    t.integer  "user_id",                        null: false
    t.integer  "num_vm_request",                 null: false
    t.integer  "vm_type",                        null: false
    t.boolean  "need_process",   default: true,  null: false
    t.boolean  "is_granted",     default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at"
  end

  add_index "single_vm_requests", ["user_id"], name: "fk_single_vm_requests_user_id_idx", using: :btree
  add_index "single_vm_requests", ["vm_type"], name: "fk_single_vm_requests_type_idx", using: :btree

  create_table "single_vm_snapshots", force: true do |t|
    t.integer "vm_id",    null: false
    t.integer "image_id", null: false
    t.integer "iso_id",   null: false
    t.string  "name",     null: false
  end

  add_index "single_vm_snapshots", ["iso_id"], name: "fk_snap_shot_iso_idx", using: :btree
  add_index "single_vm_snapshots", ["vm_id"], name: "fk_snap_shot_vm_idx", using: :btree

  create_table "users", force: true do |t|
    t.string  "username",  limit: 45,                 null: false
    t.boolean "activated",            default: false, null: false
    t.integer "role"
  end

  create_table "vm_types", force: true do |t|
    t.string  "name",                null: false
    t.integer "cpus",                null: false
    t.integer "ram",                 null: false
    t.float   "price", default: 1.0, null: false
    t.float   "ratio"
  end

  create_table "vms", primary_key: "vm_id", force: true do |t|
    t.integer  "user_id",                                  null: false
    t.string   "hostname"
    t.integer  "vm_type",                                  null: false
    t.integer  "state",                    default: 0,     null: false
    t.integer  "iso_id",                   default: 1,     null: false
    t.string   "suffix_mac"
    t.string   "ip"
    t.boolean  "is_single",                default: false, null: false
    t.boolean  "is_group",                 default: false, null: false
    t.datetime "created_at"
    t.datetime "expire_at"
    t.integer  "is_activated",   limit: 1, default: 0,     null: false
    t.integer  "allocated_vmid"
  end

  add_index "vms", ["iso_id"], name: "fk_hosts_iso_idx", using: :btree
  add_index "vms", ["user_id"], name: "fk_user_id_idx", using: :btree
  add_index "vms", ["vm_type"], name: "fk_vms_vm_type_idx", using: :btree

end
