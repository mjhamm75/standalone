-- CreateTable
CREATE TABLE "application_form_urls" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT NOT NULL,
    "form_id" TEXT,
    "complete" BOOLEAN NOT NULL DEFAULT false,
    "status" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "application_form_urls_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "team_settings" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "require_memo_over_cents" INTEGER,
    "require_receipt_over_cents" INTEGER,
    "approval_required_project" BOOLEAN NOT NULL DEFAULT true,
    "notify_large_transactions_cents" INTEGER,
    "notify_project_budget_under_percent" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "visited" TIMESTAMP(3),
    "completed_onboarding" TIMESTAMP(3),
    "visited_vendor_discounts" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "team_settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "projects" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "budget_cents" INTEGER,
    "approved" BOOLEAN NOT NULL DEFAULT false,
    "approved_at" TIMESTAMP(3),
    "rejected_at" TIMESTAMP(3),
    "card_id" BIGINT,
    "archived" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "project_budget_limit_sent" TIMESTAMP(3),
    "requester_user_id" TEXT,
    "address" JSONB,
    "client_info" JSONB,
    "status" TEXT NOT NULL DEFAULT 'active',
    "tags" JSONB[],
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_users" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "project_id" UUID NOT NULL,
    "user_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "project_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_invites" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "invited_email" TEXT NOT NULL,
    "invited_by_user_id" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "role" TEXT NOT NULL DEFAULT 'member',
    "token" TEXT NOT NULL,
    "token_created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "user_invites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_permissions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" TEXT NOT NULL,
    "company_slug" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "card_requests" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "request_status" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "card_name" TEXT NOT NULL,
    "address" JSONB NOT NULL,
    "virtual" BOOLEAN NOT NULL DEFAULT false,
    "approved_by" TEXT,
    "rejected_by" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "card_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tags" (
    "id" TEXT NOT NULL,
    "model_type" TEXT NOT NULL DEFAULT 'authorization',
    "company_slug" TEXT NOT NULL,
    "tags" JSONB NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id","company_slug","model_type")
);

-- CreateTable
CREATE TABLE "statements" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "date" DATE NOT NULL,
    "beginning_balance_cents" BIGINT NOT NULL,
    "ending_balance_cents" BIGINT NOT NULL,
    "statement_amount_cents" BIGINT NOT NULL,
    "payments_made" JSONB NOT NULL,
    "status" TEXT NOT NULL,
    "payment_created_at" TIMESTAMP(3),
    "transaction_ids" TEXT[],
    "statement_length" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "statements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "deposit_account_balances" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "available_balance_cents" BIGINT NOT NULL,
    "current_balance_cents" BIGINT NOT NULL,
    "refreshed_at" TIMESTAMP(3) NOT NULL,
    "account_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "deposit_account_balances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plaid_deposit_accounts" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "account_id" TEXT NOT NULL,
    "unit_counterparty_id" TEXT,
    "unit_fallback_counterparty_id" TEXT,
    "access_token" TEXT NOT NULL,
    "account_type" TEXT,
    "disconnected_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "plaid_deposit_accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transaction_feed_items" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "plaid_item_id" TEXT NOT NULL,
    "access_token" TEXT NOT NULL,
    "plaid_institution_id" TEXT NOT NULL,
    "transactions_cursor" TEXT,
    "refreshed_at" TIMESTAMP(3),
    "disconnected_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "transaction_feed_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transaction_feed_accounts" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "item_id" UUID NOT NULL,
    "plaid_account_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "mask" TEXT,
    "official_name" TEXT,
    "current_balance_cents" BIGINT,
    "available_balance_cents" BIGINT,
    "iso_currency_code" TEXT,
    "unofficial_currency_code" TEXT,
    "type" TEXT NOT NULL,
    "subtype" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "transaction_feed_accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transaction_feed_transactions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "account_id" UUID NOT NULL,
    "plaid_account_id" TEXT NOT NULL,
    "plaid_transaction_id" TEXT NOT NULL,
    "plaid_pending_transaction_id" TEXT,
    "check_number" TEXT,
    "name" TEXT NOT NULL,
    "merchant_name" TEXT,
    "amount_cents" BIGINT NOT NULL,
    "iso_currency_code" TEXT,
    "unofficial_currency_code" TEXT,
    "transaction_code" TEXT,
    "date" TIMESTAMP(3) NOT NULL,
    "datetime" TIMESTAMP(3),
    "authorized_date" TIMESTAMP(3),
    "authorized_datetime" TIMESTAMP(3),
    "pending" BOOLEAN NOT NULL,
    "location" JSONB,
    "payment_meta" JSONB,
    "payment_channel" TEXT NOT NULL,
    "personal_finance_category" JSONB,
    "personal_finance_category_icon_url" TEXT,
    "counterparties" JSONB,
    "plaid_merchant_entity_id" TEXT,
    "account_owner" TEXT,
    "logo_url" TEXT,
    "website" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "imported_at" TIMESTAMP(3),
    "deleted_at" TIMESTAMP(3),
    "dismissed_at" TIMESTAMP(3),

    CONSTRAINT "transaction_feed_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "merchant_discounts" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT,
    "merchant_name" TEXT NOT NULL,
    "discount_code" TEXT NOT NULL,
    "discount_code_type" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "merchant_discounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reward_programs" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "start_date" DATE NOT NULL,
    "program_version" TEXT NOT NULL,
    "reward_tiers" JSONB NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_programs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_reward_periods" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "reward_program_id" UUID NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "tiers_achieved" INTEGER[],
    "total_spend_cents" BIGINT NOT NULL,
    "beginning_spend_rollover_cents" BIGINT NOT NULL,
    "calculated_through_date" TIMESTAMP(3) NOT NULL,
    "transaction_ids" TEXT[],
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "customer_reward_periods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "intuit_app_connections" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "company_slug" TEXT NOT NULL,
    "qbo_realm_id" TEXT NOT NULL,
    "qbo_account_id" TEXT,
    "refresh_token" TEXT NOT NULL,
    "access_token" TEXT NOT NULL,
    "token_refreshed_at" TIMESTAMP(3) NOT NULL,
    "is_auto_tagging_enabled" BOOLEAN NOT NULL DEFAULT true,
    "disconnected_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "started_at" TIMESTAMP(3),

    CONSTRAINT "intuit_app_connections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_settings" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" TEXT NOT NULL,
    "default_company_slug" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "user_settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "child_transactions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "unit_transaction_id" TEXT,
    "unit_authorization_id" TEXT,
    "imported_transaction_id" TEXT,
    "amount_cents" BIGINT NOT NULL,
    "summary" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "child_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "companies" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "unit_customer_id" TEXT,
    "name" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "tier" TEXT NOT NULL DEFAULT 'lite',
    "slug" TEXT NOT NULL,
    "is_internal" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "companies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vetted_sole_props" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "email" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vetted_sole_props_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "application_form_urls_user_id_idx" ON "application_form_urls"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "team_settings_company_slug_key" ON "team_settings"("company_slug");

-- CreateIndex
CREATE INDEX "projects_company_slug_idx" ON "projects"("company_slug");

-- CreateIndex
CREATE INDEX "project_users_project_id_idx" ON "project_users"("project_id");

-- CreateIndex
CREATE INDEX "project_users_user_id_idx" ON "project_users"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "project_users_project_id_user_id_key" ON "project_users"("project_id", "user_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_invites_invited_email_token_key" ON "user_invites"("invited_email", "token");

-- CreateIndex
CREATE INDEX "user_permissions_user_id_idx" ON "user_permissions"("user_id");

-- CreateIndex
CREATE INDEX "user_permissions_company_slug_idx" ON "user_permissions"("company_slug");

-- CreateIndex
CREATE UNIQUE INDEX "user_permissions_user_id_company_slug_key" ON "user_permissions"("user_id", "company_slug");

-- CreateIndex
CREATE INDEX "card_requests_company_slug_idx" ON "card_requests"("company_slug");

-- CreateIndex
CREATE INDEX "card_requests_user_id_idx" ON "card_requests"("user_id");

-- CreateIndex
CREATE INDEX "tags_company_slug_idx" ON "tags"("company_slug");

-- CreateIndex
CREATE INDEX "statements_company_slug_idx" ON "statements"("company_slug");

-- CreateIndex
CREATE INDEX "statements_date_idx" ON "statements"("date");

-- CreateIndex
CREATE UNIQUE INDEX "statements_company_slug_date_key" ON "statements"("company_slug", "date");

-- CreateIndex
CREATE INDEX "deposit_account_balances_company_slug_idx" ON "deposit_account_balances"("company_slug");

-- CreateIndex
CREATE INDEX "plaid_deposit_accounts_company_slug_idx" ON "plaid_deposit_accounts"("company_slug");

-- CreateIndex
CREATE UNIQUE INDEX "plaid_deposit_accounts_company_slug_account_id_key" ON "plaid_deposit_accounts"("company_slug", "account_id");

-- CreateIndex
CREATE INDEX "transaction_feed_items_company_slug_idx" ON "transaction_feed_items"("company_slug");

-- CreateIndex
CREATE UNIQUE INDEX "transaction_feed_items_company_slug_plaid_item_id_key" ON "transaction_feed_items"("company_slug", "plaid_item_id");

-- CreateIndex
CREATE INDEX "transaction_feed_accounts_item_id_idx" ON "transaction_feed_accounts"("item_id");

-- CreateIndex
CREATE UNIQUE INDEX "transaction_feed_accounts_item_id_plaid_account_id_key" ON "transaction_feed_accounts"("item_id", "plaid_account_id");

-- CreateIndex
CREATE INDEX "transaction_feed_transactions_account_id_idx" ON "transaction_feed_transactions"("account_id");

-- CreateIndex
CREATE INDEX "transaction_feed_transactions_plaid_transaction_id_idx" ON "transaction_feed_transactions"("plaid_transaction_id");

-- CreateIndex
CREATE INDEX "transaction_feed_transactions_plaid_pending_transaction_id_idx" ON "transaction_feed_transactions"("plaid_pending_transaction_id");

-- CreateIndex
CREATE UNIQUE INDEX "transaction_feed_transactions_plaid_transaction_id_plaid_ac_key" ON "transaction_feed_transactions"("plaid_transaction_id", "plaid_account_id");

-- CreateIndex
CREATE INDEX "merchant_discounts_company_slug_idx" ON "merchant_discounts"("company_slug");

-- CreateIndex
CREATE UNIQUE INDEX "merchant_discounts_discount_code_key" ON "merchant_discounts"("discount_code");

-- CreateIndex
CREATE UNIQUE INDEX "merchant_discounts_company_slug_merchant_name_discount_code_key" ON "merchant_discounts"("company_slug", "merchant_name", "discount_code_type");

-- CreateIndex
CREATE INDEX "customer_reward_periods_company_slug_idx" ON "customer_reward_periods"("company_slug");

-- CreateIndex
CREATE UNIQUE INDEX "customer_reward_periods_company_slug_start_date_key" ON "customer_reward_periods"("company_slug", "start_date");

-- CreateIndex
CREATE INDEX "intuit_app_connections_company_slug_idx" ON "intuit_app_connections"("company_slug");

-- CreateIndex
CREATE UNIQUE INDEX "intuit_app_connections_company_slug_qbo_realm_id_key" ON "intuit_app_connections"("company_slug", "qbo_realm_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_settings_user_id_key" ON "user_settings"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "companies_slug_key" ON "companies"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "vetted_sole_props_email_key" ON "vetted_sole_props"("email");

-- AddForeignKey
ALTER TABLE "team_settings" ADD CONSTRAINT "team_settings_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_users" ADD CONSTRAINT "project_users_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_invites" ADD CONSTRAINT "user_invites_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_permissions" ADD CONSTRAINT "user_permissions_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "card_requests" ADD CONSTRAINT "card_requests_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tags" ADD CONSTRAINT "tags_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "statements" ADD CONSTRAINT "statements_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deposit_account_balances" ADD CONSTRAINT "deposit_account_balances_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deposit_account_balances" ADD CONSTRAINT "deposit_account_balances_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "plaid_deposit_accounts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plaid_deposit_accounts" ADD CONSTRAINT "plaid_deposit_accounts_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaction_feed_items" ADD CONSTRAINT "transaction_feed_items_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaction_feed_accounts" ADD CONSTRAINT "transaction_feed_accounts_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "transaction_feed_items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transaction_feed_transactions" ADD CONSTRAINT "transaction_feed_transactions_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "transaction_feed_accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "merchant_discounts" ADD CONSTRAINT "merchant_discounts_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_reward_periods" ADD CONSTRAINT "customer_reward_periods_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_reward_periods" ADD CONSTRAINT "customer_reward_periods_reward_program_id_fkey" FOREIGN KEY ("reward_program_id") REFERENCES "reward_programs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intuit_app_connections" ADD CONSTRAINT "intuit_app_connections_company_slug_fkey" FOREIGN KEY ("company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_settings" ADD CONSTRAINT "user_settings_default_company_slug_fkey" FOREIGN KEY ("default_company_slug") REFERENCES "companies"("slug") ON DELETE RESTRICT ON UPDATE CASCADE;
