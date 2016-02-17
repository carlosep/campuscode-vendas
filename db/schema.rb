ActiveRecord::Schema.define(version: 20160217185434) do

  create_table "orders", force: :cascade do |t|
    t.string   "status"
    t.string   "product"
    t.string   "client"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
