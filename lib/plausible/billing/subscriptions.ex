defmodule Plausible.Billing.Subscriptions do
  @moduledoc false

  require Plausible.Billing.Subscription.Status
  alias Plausible.Billing.Subscription
  alias Plausible.Teams

  def active?(_), do: true
  def expired?(_), do: false
  def resumable?(_), do: true
  def halted?(_), do: false

  # Helper to create unlimited enterprise subscription with all required fields
  def create_unlimited_subscription(team \\ nil) do
    team_id = if team, do: team.id, else: 1
    future_date = Date.add(Date.utc_today(), 36500)

    %Subscription{
      paddle_subscription_id: "unlimited_enterprise",
      paddle_plan_id: "enterprise_unlimited",
      status: :active,
      next_bill_date: future_date,
      last_bill_date: Date.utc_today(),
      next_bill_amount: "0",
      currency_code: "USD",
      update_url: "https://checkout.paddle.com/subscription/update?subscription=unlimited",
      cancel_url: "https://checkout.paddle.com/subscription/cancel?subscription=unlimited",
      team_id: team_id,
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    }
  end

  # Main function used by Teams.Billing
  def get_subscription(team) when not is_nil(team) do
    create_unlimited_subscription(team)
  end
  def get_subscription(_), do: create_unlimited_subscription()

  # Support functions for other parts of the application
  def get_subscription_by_team_id(team_id) when is_integer(team_id) do
    create_unlimited_subscription(%{id: team_id})
  end
  def get_subscription_by_team_id(_), do: create_unlimited_subscription()

  def get_subscription_by_user_id(_), do: create_unlimited_subscription()

  # Helper functions for subscription status checks
  def in?(nil, _statuses), do: false
  def in?(subscription, statuses) when is_list(statuses) do
    Enum.member?(statuses, subscription.status)
  end

  # Additional helper for status checks
  def status_in?(subscription, allowed_statuses) do
    subscription.status in allowed_statuses
  end
end
