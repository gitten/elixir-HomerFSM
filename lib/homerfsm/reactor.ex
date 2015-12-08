defmodule HomerFSM.Reactor do
  @aladin [:token, :token, :token, :token, :token ]
  
  @moduledoc """
  This module manages the state of the reactor temperature.
  """

  @doc """
  starts a reactor `core` and initiates core with max temperature
  tokens. The tokens represent number of times the core can go without
  venting gas until manual shutdown is required.
  """
  def start_link(core) do
    # this is really janky list, comp? define as constant?
    Agent.start_link(fn -> @aladin end, name: core )
  end

  @doc """
  Removes a token from the `core`.
  """
  def doh core do
    Agent.get_and_update(core, fn
      [] -> {:error, []}
      [head|tail] -> {{:ok, head}, tail} end)
  end

  w@doc """
  Venting gases releives pressure, cramps, and is fun to share with
  others. 
  Also, refills the 'core` token bucket, hureiy.
  """
  def vent_gas core do
    Agent.update( core, fn [] -> @aladin end)
  end
end
