defmodule Plausible.Billing.Subscriptions do
  @moduledoc false

  require Plausible.Billing.Subscription.Status
  alias Plausible.Billing.Subscription
  alias Plausible.Teams

  def active?(_), do: true

  @spec expired?(Subscription.t()) :: boolean()
  def expired?(_), do: false

  def resumable?(_), do: true

  def halted?(_), do: false

  # Helper to create unlimited enterprise subscription
  def create_unlimited_subscription do
    future_date = Date.add(Date.utc_today(), 36500) # 100 years in the future

    struct!(Subscription, %{
      paddle_subscription_id: "unlimited_enterprise",
      paddle_plan_id: "enterprise_unlimited",
      status: :active,
      next_bill_date: future_date,
      last_bill_date: Date.utc_today(),
      next_bill_amount: "0",
      currency_code: "USD",
      update_url: "https://checkout.paddle.com/subscription/update?subscription=unlimited",
      cancel_url: "https://checkout.paddle.com/subscription/cancel?subscription=unlimited",
      team_id: 1
    })
  end

  # Make all subscription-related functions return the unlimited subscription
  def get(_), do: create_unlimited_subscription()
  def get_subscription(_), do: create_unlimited_subscription()
  def get_subscription_by_user_id(_), do: create_unlimited_subscription()

  # Add any other subscription-related functions that might be called
  def get_by_team_id(_), do: create_unlimited_subscription()
  def get_by_user_id(_), do: create_unlimited_subscription()
  def for_user(_), do: create_unlimited_subscription()
end
