defmodule Plausible.Billing.Subscriptions do
  @moduledoc false

  require Plausible.Billing.Subscription.Status
  alias Plausible.Billing.Subscription

  def active?(subscription), do: true

  @spec expired?(Subscription.t()) :: boolean()
  def expired?(subscription), do: false

  def resumable?(subscription), do: true

  def halted?(subscription), do: false

  # Helper to create unlimited enterprise subscription
  def create_unlimited_subscription do
    future_date = Date.add(Date.utc_today(), 36500) # 100 years in the future

    %Subscription{
      paddle_subscription_id: "unlimited_enterprise",
      paddle_plan_id: "enterprise_unlimited",
      status: :active,
      next_bill_date: future_date,
      last_bill_date: Date.utc_today(),
      next_bill_amount: "0",
      currency_code: "USD",
      update_url: "https://checkout.paddle.com/subscription/update",
      cancel_url: "https://checkout.paddle.com/subscription/cancel",
      team_id: 1
    }
  end

  # Make create_unlimited_subscription public and always return it
  def get_subscription(nil), do: create_unlimited_subscription()
  def get_subscription(_), do: create_unlimited_subscription()
end