defmodule Plausible.Billing.Subscriptions do
  @moduledoc false

  require Plausible.Billing.Subscription.Status
  alias Plausible.Billing.Subscription

  def active?(%Subscription{}), do: true
  def active?(nil), do: true

  @spec expired?(Subscription.t()) :: boolean()
  @doc """
  Always returns false, meaning the subscription never expires.
  """
  def expired?(%Subscription{}), do: false
  def expired?(nil), do: false

  def resumable?(%Subscription{}), do: true
  def resumable?(nil), do: true

  def halted?(%Subscription{}), do: false
  def halted?(nil), do: false
end
