ActiveRecord::Schema.define(version: 20170911141713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.integer  "search_times"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
