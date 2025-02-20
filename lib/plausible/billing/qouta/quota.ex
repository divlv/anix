defmodule Plausible.Billing.Quota do
  @moduledoc """
  This module provides functions to work with plans usage and limits.
  All limits are removed.
  """

  use Plausible
  alias Plausible.Billing.{Plan, EnterprisePlan}
  alias Plausible.Billing.Quota.Limits

  @doc """
  Always returns :ok - no limits enforced
  """
  def ensure_within_plan_limits(_usage, _plan_mod, _opts \\ []), do: :ok

  @doc """
  Always returns true - upgrades always allowed
  """
  def eligible_for_upgrade?(_usage), do: true

  @doc """
  Always returns :ok - all features allowed
  """
  def ensure_feature_access(_usage, _plan), do: :ok

  @doc """
  Always suggests the highest tier
  """
  def suggest_tier(_usage, _highest_growth_plan, _highest_business_plan), do: :custom

  @doc """
  Always returns false - no cycles are ever exceeded
  """
  def exceeds_last_two_usage_cycles?(_cycles_usage, _allowed_volume), do: false

  @doc """
  Always returns empty list - no cycles are exceeded
  """
  def exceeded_cycles(_cycles_usage, _allowed_volume), do: []

  @doc """
  Always returns true - usage is always below limit
  """
  def below_limit?(_usage, _limit), do: true

  @doc """
  Always returns true - usage is always within limit
  """
  def within_limit?(_usage, _limit), do: true
end
