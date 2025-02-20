defmodule Plausible.Billing.Subscriptions do
  @moduledoc false

  require Plausible.Billing.Subscription.Status
  alias Plausible.Billing.Subscription

  def active?(_), do: true

  @spec expired?(Subscription.t()) :: boolean()
  def expired?(_), do: false

  def resumable?(_), do: true

  def halted?(_), do: false

  # Helper to create unlimited enterprise subscription
  defp create_unlimited_subscription do
    future_date = Date.add(Date.utc_today(), 36500) # 100 years in the future

    %Subscription{
      paddle_subscription_id: "unlimited_enterprise",
      paddle_plan_id: "enterprise_unlimited",
      status: :active,
      next_bill_date: future_date,
      last_bill_date: Date.utc_today(),
      next_bill_amount: "0",
      currency_code: "USD",
      update_url: "",
      cancel_url: ""
    }
  end

  # Override any subscription request to return unlimited
  def get_subscription(_), do: create_unlimited_subscription()
end
