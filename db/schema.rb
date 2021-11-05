# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_04_004434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "abokifxes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "sell_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "buy_rate"
    t.index ["sell_rate"], name: "index_abokifxes_on_sell_rate"
  end

  create_table "account_balance_updates", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "account_id"
    t.uuid "account_transaction_id"
    t.string "update_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "new_confirmed_balance"
    t.decimal "new_unconfirmed_balance"
    t.decimal "previous_confirmed_balance"
    t.decimal "previous_unconfirmed_balance"
    t.string "cryptocurrency"
    t.decimal "amount"
    t.uuid "payment_id"
    t.decimal "new_confirmed_credit_balance", default: "0.0"
    t.decimal "new_unconfirmed_credit_balance", default: "0.0"
    t.decimal "previous_confirmed_credit_balance", default: "0.0"
    t.decimal "previous_unconfirmed_credit_balance", default: "0.0"
    t.index ["account_id", "account_transaction_id", "update_type"], name: "index_balance_update_uniqueness", unique: true
    t.index ["account_id"], name: "index_account_balance_updates_on_account_id"
  end

  create_table "account_transactions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "txhash"
    t.uuid "address_id"
    t.boolean "confirmed"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "account_id"
    t.string "direction"
    t.uuid "user_id"
    t.uuid "escrow_account_id"
    t.string "transaction_type"
    t.string "cryptocurrency"
    t.string "source_id"
    t.decimal "source_fee"
    t.decimal "bitkoin_fee"
    t.string "from"
    t.string "to"
    t.string "api_key"
    t.string "status", default: "done", null: false
    t.string "to_address"
    t.uuid "order_id"
    t.uuid "refunded_order_id"
    t.uuid "transactable_id"
    t.string "transactable_type"
    t.index ["created_at"], name: "index_account_transactions_on_created_at"
    t.index ["cryptocurrency"], name: "index_account_transactions_on_cryptocurrency"
    t.index ["order_id", "transaction_type", "created_at"], name: "idx_account_trxs_on_order_id_and_transaction_type"
    t.index ["source_id", "address_id"], name: "index_account_transactions_on_source_id_and_address_id", unique: true
    t.index ["txhash", "direction", "address_id", "amount"], name: "txhash_uniqueness", unique: true
    t.index ["user_id", "transaction_type", "cryptocurrency"], name: "idx_acct_txs_on_user_id_transaction_type_etc"
    t.index ["user_id"], name: "index_account_transactions_on_user_id"
  end

  create_table "accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.decimal "confirmed_balance", default: "0.0"
    t.decimal "unconfirmed_balance", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "locked_balance", default: "0.0"
    t.jsonb "lock_state", default: {}
    t.string "cryptocurrency"
    t.decimal "max_credit_line", default: "0.0"
    t.decimal "confirmed_credit_balance", default: "0.0"
    t.decimal "unconfirmed_credit_balance", default: "0.0"
    t.datetime "negative_balance_since"
    t.datetime "charge_penalty_at"
    t.index ["created_at"], name: "index_accounts_on_created_at"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "addresses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cryptocurrency"
    t.string "created_on", default: "bitkoin"
    t.uuid "user_id"
    t.string "source_bridge"
    t.index ["address", "cryptocurrency"], name: "index_addresses_on_address_and_cryptocurrency"
    t.index ["cryptocurrency"], name: "index_addresses_on_cryptocurrency"
    t.index ["source_bridge"], name: "index_addresses_on_source_bridge"
  end

  create_table "api_credentials", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "public_key", null: false
    t.string "encrypted_secret_key", null: false
    t.string "webhook_url"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.string "webhook_token"
    t.index ["discarded_at"], name: "index_api_credentials_on_discarded_at"
  end

  create_table "app_notices", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audits", id: :serial, force: :cascade do |t|
    t.uuid "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.uuid "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "available_trading_pairs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.jsonb "products", default: [], null: false
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "exchange", default: "gdax"
  end

  create_table "bank_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "bank_code"
    t.string "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_name"
    t.boolean "has_internet_banking", default: false
    t.string "paystack_recipient_code"
    t.string "account_type", default: "withdrawal"
    t.string "unique_account_reference"
    t.boolean "for_api", default: false
    t.string "mono_recipient_token"
    t.boolean "mono_verified", default: false, null: false
    t.string "bank_name"
    t.boolean "sherlock_connected", default: false, null: false
    t.boolean "sherlock_supported", default: false, null: false
    t.string "linked_bvn"
    t.index ["account_number", "user_id"], name: "index_bank_accounts_on_account_number_and_user_id", unique: true
    t.index ["linked_bvn"], name: "index_bank_accounts_on_linked_bvn"
    t.index ["user_id", "account_number"], name: "index_bank_accounts_on_user_id_and_account_number", unique: true
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "bank_transfer_trackers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "market_match_id"
    t.uuid "sender_market_match_payment_id"
    t.uuid "recipient_market_match_payment_id"
    t.uuid "sender_bank_account_id"
    t.uuid "recipient_bank_account_id"
    t.boolean "sender_debited", default: false, null: false
    t.boolean "recipient_credited", default: false, null: false
    t.datetime "sender_debited_at"
    t.datetime "recipient_credited_at"
    t.text "sender_debit_narration"
    t.text "recipient_credit_narration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.uuid "deposit_id"
    t.uuid "withdrawal_id"
    t.string "channel", default: "bank"
    t.uuid "recipient_id"
    t.uuid "sender_id"
    t.uuid "sender_payment_channel_id"
    t.uuid "recipient_payment_channel_id"
    t.index ["deposit_id"], name: "index_bank_transfer_trackers_on_deposit_id"
    t.index ["market_match_id"], name: "index_bank_transfer_trackers_on_market_match_id"
    t.index ["recipient_bank_account_id"], name: "index_bank_transfer_trackers_on_recipient_bank_account_id"
    t.index ["recipient_market_match_payment_id"], name: "idx_recipient_market_match_payment_id"
    t.index ["recipient_payment_channel_id"], name: "index_bank_transfer_trackers_on_recipient_payment_channel_id"
    t.index ["sender_bank_account_id"], name: "index_bank_transfer_trackers_on_sender_bank_account_id"
    t.index ["sender_market_match_payment_id"], name: "idx_sender_market_match_payment_id"
    t.index ["sender_payment_channel_id"], name: "index_bank_transfer_trackers_on_sender_payment_channel_id"
    t.index ["withdrawal_id"], name: "index_bank_transfer_trackers_on_withdrawal_id"
  end

  create_table "banks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "binance_order_fills", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "price"
    t.decimal "quantity"
    t.decimal "commission"
    t.decimal "commission_asset"
    t.integer "trade_id"
    t.uuid "binance_order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "binance_orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "symbol"
    t.integer "order_id"
    t.integer "order_list_id"
    t.string "client_order_id"
    t.datetime "transact_time"
    t.decimal "price"
    t.decimal "orig_quantity"
    t.decimal "executed_quantity"
    t.decimal "cummulative_quote_qty"
    t.string "status"
    t.string "time_in_force"
    t.string "order_type"
    t.string "side"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "binance_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "cryptocurrency"
    t.decimal "price_kobo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "trade_fee"
    t.index ["cryptocurrency"], name: "index_binance_prices_on_cryptocurrency"
  end

  create_table "bitstamp_prices", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "cryptocurrency"
    t.decimal "fiat_rate"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buycoins_prices", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "buy_price_kobo"
    t.decimal "sell_price_kobo"
    t.decimal "sell_exchange_rate"
    t.string "cryptocurrency"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "best_ask_dollars"
    t.decimal "best_bid_dollars"
    t.decimal "best_ask_kobo"
    t.decimal "best_bid_kobo"
    t.decimal "max_sell_coins", default: "0.0"
    t.decimal "max_buy_coins", default: "0.0"
    t.string "exchange"
    t.decimal "buy_exchange_rate"
    t.boolean "is_high_volume", default: false
    t.boolean "staggered", default: false
    t.decimal "api_buy_price_kobo"
    t.decimal "api_sell_price_kobo"
    t.boolean "queued_for_expiry", default: false
    t.index ["cryptocurrency", "created_at"], name: "index_buycoins_prices_on_cryptocurrency_and_created_at"
    t.index ["max_buy_coins"], name: "index_buycoins_prices_on_max_buy_coins"
    t.index ["max_sell_coins"], name: "index_buycoins_prices_on_max_sell_coins"
    t.index ["staggered", "cryptocurrency", "is_high_volume", "status"], name: "idx_buycoins_prices_on_staggered_cryptocurrency_etc"
    t.index ["status", "created_at"], name: "index_buycoins_prices_on_status_and_created_at"
    t.index ["status", "queued_for_expiry"], name: "index_buycoins_prices_on_status_and_queued_for_expiry"
  end

  create_table "bvn_caches", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "bvn"
    t.jsonb "body", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_bvn_caches_on_user_id"
  end

  create_table "callback_events", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "client"
    t.string "reference"
    t.string "event"
    t.jsonb "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client", "event", "reference"], name: "index_callback_events_on_client_and_event_and_reference"
  end

  create_table "chatbot_settings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "cryptocurrency", default: "bitcoin"
    t.decimal "offer_notification_minimum", default: "0.0"
    t.decimal "offer_notification_maximum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chatbot_settings_on_user_id"
  end

  create_table "chats", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "platform", default: "telegram"
    t.string "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "authenticated", default: false
  end

  create_table "coin_fee_charge_records", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "trade_id"
    t.uuid "account_transaction_id"
    t.decimal "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coin_transfers", id: :uuid, default: -> { "uuid_generate_v4()" }, comment: "Records Transfers to GDAX Trading Account", force: :cascade do |t|
    t.decimal "amount", null: false, comment: "Amount Transferred"
    t.string "gdax_deposit_id", comment: "ID returned when Coins are deposited from GDAX Coinbase into the GDAX Trading Account"
    t.string "cryptocurrency", null: false, comment: "Transferred Currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", comment: "User the coin was sent on behalf of"
    t.string "transfer_type", default: "to_gdax", null: false
    t.string "gdax_withdrawal_id"
  end

  create_table "coinlocks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "cryptocurrency"
    t.decimal "amount", precision: 10, scale: 2
    t.decimal "interest", precision: 10, scale: 2
    t.integer "duration_in_months"
    t.date "maturity_date"
    t.string "status", default: "locked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "interest_percentage"
  end

  create_table "credit_details", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "currency"
    t.decimal "max", default: "0.0"
    t.datetime "negative_balance_since"
    t.datetime "charge_penalty_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "first_penalty_charge_at"
    t.index ["user_id"], name: "index_credit_details_on_user_id"
  end

  create_table "crypto_average_fees", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "litecoin_average_fee"
    t.decimal "ethereum_average_fee"
    t.decimal "bitcoin_cash_average_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "bitcoin_average_fee"
    t.decimal "naira_token_average_fee", default: "50.0"
    t.decimal "bsc_naira_token_average_fee"
    t.decimal "trx_usd_tether_average_fee"
  end

  create_table "crypto_prices", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "bitcoin_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "bitcoin_cash_rate"
    t.decimal "litecoin_rate"
    t.decimal "ethereum_rate"
  end

  create_table "double_entry_account_balances", id: :serial, force: :cascade do |t|
    t.string "account", null: false
    t.string "scope"
    t.bigint "balance", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account"], name: "index_account_balances_on_account"
    t.index ["scope", "account"], name: "index_account_balances_on_scope_and_account", unique: true
    t.index ["scope", "account"], name: "index_double_entry_account_balances_on_scope_and_account"
  end

  create_table "double_entry_line_checks", id: :serial, force: :cascade do |t|
    t.integer "last_line_id", null: false
    t.boolean "errors_found", null: false
    t.text "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at", "last_line_id"], name: "line_checks_created_at_last_line_id_idx"
  end

  create_table "double_entry_lines", id: :serial, force: :cascade do |t|
    t.string "account", null: false
    t.string "scope"
    t.string "code", null: false
    t.bigint "amount", null: false
    t.bigint "balance", null: false
    t.integer "partner_id"
    t.string "partner_account", null: false
    t.string "partner_scope"
    t.string "detail_type"
    t.jsonb "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "detail_id"
    t.index ["account", "code", "created_at"], name: "lines_account_code_created_at_idx"
    t.index ["account", "code", "detail_type", "detail_id"], name: "lines_account_code_detail_idx"
    t.index ["account", "created_at"], name: "lines_account_created_at_idx"
    t.index ["created_at"], name: "index_double_entry_lines_on_created_at"
    t.index ["detail_type", "detail_id"], name: "index_double_entry_lines_on_detail_type_and_detail_id"
    t.index ["scope", "account", "created_at"], name: "lines_scope_account_created_at_idx"
    t.index ["scope", "account", "id"], name: "lines_scope_account_id_idx"
    t.index ["scope"], name: "index_double_entry_lines_on_scope"
  end

  create_table "escrow_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "bitcoin_balance", default: "0.0"
    t.decimal "naira_balance", default: "0.0"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "ethereum_balance", default: "0.0"
    t.decimal "litecoin_balance", default: "0.0"
    t.decimal "bitcoin_cash_balance", default: "0.0"
    t.decimal "naira_token_balance", default: "0.0"
    t.decimal "usd_coin_balance", default: "0.0"
    t.index ["created_at"], name: "index_escrow_accounts_on_created_at"
    t.index ["user_id"], name: "index_escrow_accounts_on_user_id"
  end

  create_table "escrow_balance_updates", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "account_transaction_id"
    t.uuid "escrow_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "payment_id"
    t.decimal "previous_balance"
    t.decimal "new_balance"
    t.decimal "amount"
    t.string "cryptocurrency"
    t.index ["account_transaction_id", "escrow_account_id"], name: "index_escrow_balance_update_uniqueness", unique: true
  end

  create_table "exchange_rates", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "sell_rate", null: false
    t.decimal "amount", null: false
    t.decimal "buy_rate", null: false
    t.string "base_currency", null: false
    t.string "quote_currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_currency"], name: "index_exchange_rates_on_base_currency"
  end

  create_table "flagged_addresses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "address"
    t.string "cryptocurrency"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flipper_features", id: :serial, force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", id: :serial, force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "hertz_deliveries", id: :serial, force: :cascade do |t|
    t.integer "notification_id", null: false
    t.string "courier", null: false
    t.datetime "created_at", null: false
    t.index ["notification_id", "courier"], name: "index_hertz_notification_deliveries_on_notification_and_courier", unique: true
  end

  create_table "hertz_notifications", id: :serial, force: :cascade do |t|
    t.string "type", null: false
    t.string "receiver_type", null: false
    t.hstore "meta", default: {}, null: false
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.uuid "receiver_id"
  end

  create_table "login_devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "client_name", null: false
    t.string "device_type", null: false
    t.string "device_name", null: false
    t.string "device_brand", null: false
    t.string "full_version", null: false
    t.string "os_name", null: false
    t.string "os_full_version", null: false
    t.string "os_family", null: false
    t.string "ip_address", null: false
    t.string "location", null: false
    t.boolean "known_profile", default: false, null: false
    t.boolean "flagged", default: false, null: false
    t.datetime "last_sign_in_at"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["device_brand"], name: "index_login_devices_on_device_brand"
    t.index ["device_name"], name: "index_login_devices_on_device_name"
    t.index ["ip_address"], name: "index_login_devices_on_ip_address"
    t.index ["os_name"], name: "index_login_devices_on_os_name"
    t.index ["user_id"], name: "index_login_devices_on_user_id"
  end

  create_table "market_match_payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.decimal "amount"
    t.uuid "market_match_id"
    t.string "status"
    t.string "payment_type"
    t.uuid "bank_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cancellation_reason"
    t.string "deposit_identifier"
    t.boolean "manual_confirmation_notification_sent", default: false, null: false
    t.string "transfers_reference"
    t.index ["bank_account_id"], name: "index_market_match_payments_on_bank_account_id"
    t.index ["market_match_id"], name: "index_market_match_payments_on_market_match_id"
    t.index ["transfers_reference"], name: "index_market_match_payments_on_transfers_reference"
    t.index ["user_id"], name: "index_market_match_payments_on_user_id"
  end

  create_table "market_matches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.decimal "rate"
    t.decimal "min_amount"
    t.decimal "max_amount"
    t.uuid "bank_account_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "amount"
    t.string "channel", default: "bank"
    t.index ["bank_account_id"], name: "index_market_matches_on_bank_account_id"
    t.index ["user_id"], name: "index_market_matches_on_user_id"
  end

  create_table "match_payables", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "market_match_id"
    t.uuid "payment_channel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["market_match_id"], name: "index_match_payables_on_market_match_id"
    t.index ["payment_channel_id"], name: "index_match_payables_on_payment_channel_id"
  end

  create_table "mini_payment_payouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "bank_account_code"
    t.string "bank_account_number"
    t.float "amount"
    t.string "status"
    t.uuid "mini_payment_id"
    t.uuid "market_match_payment_id"
    t.string "channel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["market_match_payment_id"], name: "index_mini_payment_payouts_on_market_match_payment_id"
    t.index ["mini_payment_id"], name: "index_mini_payment_payouts_on_mini_payment_id"
  end

  create_table "offers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "price"
    t.decimal "amount"
    t.string "side"
    t.string "status", default: "open"
    t.uuid "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_with_margin"
    t.uuid "poster_id"
    t.string "poster_message_id"
    t.uuid "engager_id"
    t.string "cryptocurrency", default: "bitcoin"
    t.decimal "trade_fee"
    t.index ["poster_message_id"], name: "index_offers_on_poster_message_id"
  end

  create_table "onchain_transfer_requests", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "address"
    t.string "cryptocurrency"
    t.decimal "amount"
    t.decimal "fee"
    t.uuid "user_id"
    t.string "status"
    t.datetime "confirmed_at"
    t.string "confirmation_token"
    t.boolean "send_all", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "for_api", default: false
    t.uuid "onchain_tx_id"
    t.boolean "published", default: false
    t.string "chain"
    t.index ["for_api"], name: "index_onchain_transfer_requests_on_for_api"
    t.index ["user_id"], name: "index_onchain_transfer_requests_on_user_id"
  end

  create_table "onchain_txes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "receiving_address_id"
    t.string "txhash"
    t.boolean "confirmed", default: false
    t.string "source_id"
    t.string "to_address"
    t.decimal "source_fee", default: "0.0"
    t.decimal "user_fee"
    t.string "source_bridge"
    t.decimal "amount", null: false
    t.string "cryptocurrency", null: false
    t.string "direction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.boolean "published", default: false
    t.string "chain"
    t.index ["confirmed"], name: "index_onchain_txes_on_confirmed"
    t.index ["receiving_address_id"], name: "index_onchain_txes_on_receiving_address_id"
    t.index ["user_id"], name: "index_onchain_txes_on_user_id"
  end

  create_table "order_items", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "source_exchange_order_id"
    t.decimal "price"
    t.decimal "size", null: false
    t.string "side", null: false
    t.string "time_in_force"
    t.string "cancel_after"
    t.boolean "post_only"
    t.datetime "time_created"
    t.decimal "fill_fees", null: false
    t.decimal "filled_size", null: false
    t.decimal "executed_value", null: false
    t.string "status", default: "pending", null: false
    t.boolean "settled", default: false, null: false
    t.string "product_id"
    t.string "cryptocurrency", null: false
    t.uuid "user_id", null: false
    t.uuid "order_id", null: false
    t.uuid "buycoins_price_id"
    t.string "order_type"
    t.string "source_exchange"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["status", "side", "source_exchange_order_id"], name: "idx_order_items_on_status_side_etc"
    t.index ["user_id"], name: "index_order_items_on_user_id"
  end

  create_table "orders", id: :uuid, default: -> { "uuid_generate_v4()" }, comment: "An Order successfuly placed on GDAX", force: :cascade do |t|
    t.string "side", null: false, comment: "Buy or Sell"
    t.string "status", default: "pending", null: false, comment: "Status of the order"
    t.string "cryptocurrency", null: false, comment: "Cryptocurrency type"
    t.uuid "user_id", null: false, comment: "User the order was placed on behalf of"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "buycoins_price_id", comment: "Price given to the user for this order"
    t.uuid "payment_id", comment: "Payment transferred to the user for this order"
    t.uuid "refund_payment_id", comment: "Refund Payment for Incomplete Buy Orders"
    t.string "transfer_reference"
    t.decimal "total_coin_amount"
    t.decimal "filled_coin_amount", default: "0.0", null: false
    t.decimal "total_usd_value", default: "0.0", null: false
    t.decimal "total_fill_fees_usd", default: "0.0", null: false
    t.string "request_id", null: false
    t.boolean "for_api", default: false
    t.string "source_exchange_order_type", default: "limit"
    t.string "user_order_type", default: "instant", null: false
    t.jsonb "metadata", default: {"trade_failure_reminder_sent"=>false}, null: false
    t.index ["buycoins_price_id"], name: "index_orders_on_buycoins_price_id", comment: "Index used to lookup Orders by Price ID."
    t.index ["created_at"], name: "index_orders_on_created_at"
    t.index ["cryptocurrency"], name: "index_orders_on_cryptocurrency"
    t.index ["metadata"], name: "index_orders_on_metadata", using: :gin
    t.index ["payment_id"], name: "index_orders_on_payment_id"
    t.index ["refund_payment_id"], name: "index_orders_on_refund_payment_id"
    t.index ["request_id"], name: "index_orders_on_request_id", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id", comment: "Index used to lookup Orders by user id."
  end

  create_table "otc_orders", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "source_exchange_order_id"
    t.string "source_exchange"
    t.decimal "cost_price_per_coin_usd"
    t.bigint "user_price_per_coin_kobo"
    t.integer "exchange_rate"
    t.decimal "size"
    t.string "side"
    t.string "cryptocurrency"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "p2p_incomes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.decimal "amount", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_channels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "channel"
    t.string "integration_type"
    t.string "integration_value"
    t.uuid "user_id"
    t.boolean "linked", default: false, null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_payment_channels_on_discarded_at"
    t.index ["integration_type"], name: "index_payment_channels_on_integration_type"
    t.index ["user_id"], name: "index_payment_channels_on_user_id"
  end

  create_table "payments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "reference"
    t.string "channel"
    t.string "processor", default: "paystack"
    t.decimal "amount_kobo"
    t.uuid "trade_id"
    t.string "status"
    t.string "payment_type"
    t.string "direction"
    t.string "currency", default: "NGN"
    t.decimal "fee_kobo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_amount_kobo"
    t.decimal "processor_fee_in_kobo", default: "0.0"
    t.string "refund_request_id"
    t.datetime "processor_timestamp"
    t.datetime "confirmed_at"
    t.text "proof"
    t.string "deposit_notification_prompt"
    t.uuid "withdrawal_bank_account_id"
    t.datetime "marked_as_paid_at"
    t.boolean "p2p", default: false
    t.integer "retries", default: 0
    t.string "request_id", null: false
    t.boolean "published", default: false
    t.uuid "deposit_bank_account_id"
    t.string "cancellation_reason"
    t.boolean "for_api", default: false
    t.string "redirect_link", default: "https://buycoins.africa", null: false
    t.index ["created_at"], name: "index_payments_on_created_at"
    t.index ["payment_type", "status"], name: "index_payments_on_payment_type_and_status"
    t.index ["payment_type", "updated_at"], name: "index_payments_on_payment_type_and_updated_at"
    t.index ["processor_timestamp"], name: "index_payments_on_processor_timestamp"
    t.index ["reference"], name: "index_payments_on_reference", unique: true
    t.index ["refund_request_id"], name: "index_payments_on_refund_request_id", unique: true
    t.index ["request_id"], name: "index_payments_on_request_id", unique: true
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "paystack_authorizations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "authorization_code"
    t.string "card_type"
    t.string "last4"
    t.string "exp_month"
    t.string "exp_year"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authorization_code"], name: "index_paystack_authorizations_on_authorization_code", unique: true
  end

  create_table "pro_orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.decimal "initial_quantity", null: false
    t.decimal "remaining_quantity", null: false
    t.decimal "price"
    t.text "side", null: false
    t.text "pair", null: false
    t.text "order_type", null: false
    t.text "time_in_force", null: false
    t.text "status", default: "pending", null: false
    t.text "engine_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "fees", default: "0.0"
    t.text "engine_message"
    t.decimal "filled", default: "0.0", null: false
    t.decimal "mean_execution_price"
    t.decimal "last_update_at_ns"
    t.boolean "processed", default: false, null: false
    t.jsonb "metadata", default: {"trade_failure_reminder_sent"=>false}, null: false
    t.index ["metadata"], name: "index_pro_orders_on_metadata", using: :gin
    t.index ["status"], name: "index_pro_orders_on_status"
    t.index ["user_id"], name: "index_pro_orders_on_user_id"
  end

  create_table "queued_transfers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "amount"
    t.string "address"
    t.uuid "user_id"
    t.string "status", default: "queued"
    t.string "cryptocurrency", default: "bitcoin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referral_rewards", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "trade_engagement_id"
    t.decimal "amount"
    t.boolean "paid", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "referrer_id"
    t.uuid "referred_id"
    t.decimal "deposit_due"
    t.decimal "trade_due"
    t.boolean "referrer_rewarded", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["referred_id"], name: "index_referrals_on_referred_id"
    t.index ["referrer_id"], name: "index_referrals_on_referrer_id"
  end

  create_table "restriction_entries", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "note"
    t.string "restrictor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entry_type", default: "restrict"
    t.string "entry_author"
    t.index ["user_id"], name: "index_restriction_entries_on_user_id"
  end

  create_table "settings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "value", null: false
    t.string "data_type", null: false
    t.string "description", null: false
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_settings_on_user_id_and_name", unique: true
  end

  create_table "support_balance_adjustments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "reason", null: false
    t.decimal "amount", null: false
    t.string "account", null: false
    t.string "cryptocurrency", null: false
    t.string "direction", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "synapse_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "synapse_generated_id"
    t.string "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["synapse_generated_id"], name: "index_synapse_users_on_synapse_generated_id", unique: true
    t.index ["user_id"], name: "index_synapse_users_on_user_id", unique: true
  end

  create_table "trade_actions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "trade_id"
    t.decimal "coin_amount"
    t.decimal "naira_amount"
    t.uuid "payment_id"
    t.uuid "account_transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "other_party_id"
    t.string "trade_action_type"
    t.string "cryptocurrency"
    t.index ["user_id", "account_transaction_id"], name: "index_trade_actions_on_user_id_and_account_transaction_id", unique: true
    t.index ["user_id", "payment_id"], name: "index_trade_actions_on_user_id_and_payment_id", unique: true
  end

  create_table "trade_ads", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "cryptocurrency"
    t.string "trade_ad_type"
    t.uuid "poster_id"
    t.bigint "poster_price_per_coin_kobo"
    t.bigint "poster_dynamic_exchange_rate_kobo"
    t.string "price_type"
    t.decimal "poster_min_amount"
    t.decimal "poster_max_amount"
    t.string "status"
    t.uuid "payment_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "engager_max_amount"
    t.decimal "engager_min_amount"
    t.bigint "engager_price_per_coin_kobo"
    t.bigint "previous_engager_price_per_coin_kobo"
    t.datetime "prices_updated_at"
    t.bigint "dynamic_price_per_coin_limit"
    t.datetime "discarded_at"
    t.boolean "is_coins_escrowed", default: false
    t.uuid "buycoins_price_id"
    t.boolean "for_api", default: false, null: false
    t.decimal "poster_amount", default: "0.0"
    t.index ["cryptocurrency", "status"], name: "index_trade_ads_on_cryptocurrency_and_status"
    t.index ["cryptocurrency", "trade_ad_type", "poster_id"], name: "idx_trade_ads_on_cryptocurrency_trade_ad_type_etc"
    t.index ["discarded_at"], name: "index_trade_ads_on_discarded_at"
    t.index ["is_coins_escrowed"], name: "index_trade_ads_on_is_coins_escrowed"
    t.index ["poster_id"], name: "index_trade_ads_on_poster_id"
    t.index ["trade_ad_type"], name: "index_trade_ads_on_trade_ad_type"
  end

  create_table "trade_dispute_evidence_requests", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "reason", null: false
    t.uuid "trade_dispute_id", null: false
    t.string "party", null: false
    t.string "status", default: "pending", null: false
    t.datetime "request_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trade_dispute_evidences", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "trade_dispute_id"
    t.string "url", null: false
    t.string "status", default: "pending"
    t.string "rejection_reason"
    t.string "party"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trade_disputes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "trade_engagement_id", null: false
    t.uuid "disputer_user_id", null: false
    t.uuid "accused_user_id", null: false
    t.string "disputer_role", null: false
    t.string "status_description"
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "claim"
    t.string "resolved_by"
    t.index ["disputer_user_id"], name: "index_trade_disputes_on_disputer_user_id"
    t.index ["status"], name: "index_trade_disputes_on_status"
    t.index ["trade_engagement_id"], name: "index_trade_disputes_on_trade_engagement_id"
  end

  create_table "trade_engagements", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "trade_ad_id"
    t.uuid "poster_id"
    t.uuid "engager_id"
    t.decimal "engager_coin_amount"
    t.bigint "engager_ppc_kobo"
    t.bigint "engager_payment_amount_kobo"
    t.decimal "margin_rate"
    t.string "status"
    t.datetime "started_at"
    t.datetime "payment_due_at"
    t.datetime "payment_made_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "seller_payment_detail_id"
    t.datetime "payment_confirmed_at"
    t.uuid "trade_fee_sale_batch_id"
    t.decimal "trade_fee"
    t.boolean "fee_sold", default: false, null: false
    t.boolean "expiry_notification_sent", default: false, null: false
    t.bigint "poster_payment_amount_kobo"
    t.boolean "for_api", default: false, null: false
    t.index ["engager_id", "status"], name: "index_trade_engagements_on_engager_id_and_status"
    t.index ["engager_id"], name: "index_trade_engagements_on_engager_id"
    t.index ["poster_id", "status"], name: "index_trade_engagements_on_poster_id_and_status"
    t.index ["poster_id"], name: "index_trade_engagements_on_poster_id"
    t.index ["status"], name: "index_trade_engagements_on_status"
    t.index ["trade_ad_id"], name: "index_trade_engagements_on_trade_ad_id"
  end

  create_table "trade_fee_sale_batches", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "total_coin_amount", default: "0.0", null: false
    t.decimal "sold_coin_amount", default: "0.0", null: false
    t.decimal "total_usd_amount", default: "0.0", null: false
    t.string "status", default: "pending", null: false
    t.string "cryptocurrency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trade_fee_sales", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.decimal "coin_amount", null: false
    t.decimal "usd_value"
    t.decimal "usd_price_per_coin", null: false
    t.string "source_exchange", null: false
    t.string "source_exchange_order_id", null: false
    t.string "status", default: "pending", null: false
    t.string "cryptocurrency", null: false
    t.uuid "trade_fee_sale_batch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_exchange_order_id"], name: "index_trade_fee_sales_on_source_exchange_order_id", unique: true
  end

  create_table "trade_feedbacks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "trade_engagement_id"
    t.uuid "receiver_id"
    t.string "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "sender_id"
    t.index ["receiver_id"], name: "index_trade_feedbacks_on_receiver_id"
    t.index ["trade_engagement_id"], name: "index_trade_feedbacks_on_trade_engagement_id"
  end

  create_table "trade_fees", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "trade_engagement_id", null: false
    t.uuid "buycoins_price_id"
    t.decimal "p2p_fee", null: false
    t.decimal "total_in_usd"
    t.string "source_exchange_order_id"
    t.decimal "p2p_fee_filled_size"
    t.string "state", default: "started"
    t.string "sold_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trade_notifications", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.boolean "btc", default: false
    t.boolean "ltc", default: false
    t.boolean "bch", default: false
    t.boolean "eth", default: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trades", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "trade_type"
    t.string "status"
    t.decimal "maximum_amount"
    t.decimal "minimum_amount"
    t.decimal "price_per_coin"
    t.uuid "poster_id"
    t.date "expiry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "dynamic", default: false
    t.string "dynamic_action"
    t.decimal "dynamic_percentage", default: "0.0"
    t.decimal "dynamic_buy_cost"
    t.decimal "dynamic_minimum_spend"
    t.decimal "previous_price_per_coin"
    t.datetime "price_updated_at"
    t.boolean "free", default: false
    t.string "cryptocurrency"
    t.boolean "infinite", default: false
    t.index ["cryptocurrency"], name: "index_trades_on_cryptocurrency"
  end

  create_table "transfers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "sender_id"
    t.uuid "recipient_id"
    t.decimal "amount"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_transfers_on_recipient_id"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
  end

  create_table "user_trade_actions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "account_transaction_id"
    t.string "user_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "trade_record_id"
    t.string "trade_record_type"
  end

  create_table "user_weather_subscriptions", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
    t.string "phone"
    t.string "otp_secret_key"
    t.string "username"
    t.string "desk_id"
    t.boolean "two_factor_authentication", default: false
    t.string "two_factor_type", default: "sms"
    t.boolean "ip_whitelisting", default: false
    t.integer "free_postings", default: 2
    t.uuid "referrer"
    t.boolean "restricted", default: false
    t.string "signed_up_with", default: "bitkoin"
    t.string "signed_in_with", default: "bitkoin"
    t.jsonb "misc", default: {}
    t.string "user_category", default: "standard"
    t.datetime "last_seen_at"
    t.string "fcm_notification_key"
    t.boolean "email_notifications", default: true, null: false
    t.datetime "discarded_at"
    t.string "account_cancellation_reason"
    t.text "restriction_note"
    t.boolean "api_enabled", default: false
    t.integer "tier", default: 0, null: false
    t.string "basic_unique_session_id"
    t.boolean "outside_nigeria", default: false
    t.json "single_account_metadata"
    t.boolean "can_deposit", default: true
    t.string "abeg_username"
    t.boolean "abeg_enabled", default: true
    t.string "pro_unique_session_id"
    t.string "bvn"
    t.string "referral_code"
    t.boolean "taken_trading_quiz", default: false, null: false
    t.string "default_account_currency", default: "naira"
    t.index ["bvn"], name: "index_users_on_bvn"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tier"], name: "index_users_on_tier"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vaults", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.decimal "balance"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "verifications", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "verification_type", null: false
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", default: "unverified"
    t.index ["created_at"], name: "index_verifications_on_created_at"
    t.index ["user_id"], name: "index_verifications_on_user_id"
  end

  create_table "waiting_list_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "score"
    t.string "referral_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "priority", default: false
    t.index ["email"], name: "index_waiting_list_users_on_email", unique: true
    t.index ["referral_code"], name: "index_waiting_list_users_on_referral_code", unique: true
  end

  create_table "whitelist_requests", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.inet "ip"
    t.boolean "verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "whitelisted_ips", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.inet "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  add_foreign_key "login_devices", "users"
  add_foreign_key "referrals", "users", column: "referred_id"
  add_foreign_key "referrals", "users", column: "referrer_id"
  add_foreign_key "trade_ads", "buycoins_prices"
  add_foreign_key "trade_engagements", "trade_fee_sale_batches"
  add_foreign_key "trade_fee_sales", "trade_fee_sale_batches"
end
