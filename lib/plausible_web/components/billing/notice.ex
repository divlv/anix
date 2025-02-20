defmodule PlausibleWeb.Components.Billing.Notice do
  use PlausibleWeb, :component

  def active_grace_period(assigns), do: ~H""
  def dashboard_locked(assigns), do: ~H""
  def premium_feature(assigns), do: ~H""
  def limit_exceeded(assigns), do: ~H""
  def subscription_cancelled(assigns), do: ~H""
  def subscription_past_due(assigns), do: ~H""
  def subscription_paused(assigns), do: ~H""
  def upgrade_ineligible(assigns), do: ~H""
  def pending_site_ownerships_notice(assigns), do: ~H""

  # Remove or empty other notice functions
end