defmodule Plausible.Billing.Subscriptions do
  @moduledoc false

  require Plausible.Billing.Subscription.Status
  alias Plausible.Billing.Subscription
  alias Plausible.Teams

  def active?(subscription), do: true

  @spec expired?(Subscription.t()) :: boolean()
  def expired?(subscription), do: false

  def resumable?(subscription), do: true

  def halted?(subscription), do: false

  # Helper to create unlimited enterprise subscription
  def create_unlimited_subscription(team \\ nil) do
    team_id = if team, do: team.id, else: 1
    future_date = Date.add(Date.utc_today(), 36500) # 100 years in the future

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
      team_id: team_id
    }
  end

  # Override subscription lookup to always return unlimited subscription
  def get_subscription_by_user_id(user_id) when is_integer(user_id) do
    {:ok, team} = Teams.get_or_create(%{id: user_id})
    create_unlimited_subscription(team)
  end

  def get_subscription_by_user_id(_), do: create_unlimited_subscription()

  # Ensure this matches the interface expected by the template
  def get_subscription(team) when not is_nil(team) do
    create_unlimited_subscription(team)
  end
  def get_subscription(_), do: create_unlimited_subscription()
end
