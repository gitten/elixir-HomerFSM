defmodule HomerFSM.Reactor do
  @aladin [:token, :token, :token, :token, :token ]
  # still kinda janky, list comp and make it variable? 

  @moduledoc """
  This module manages the state of the reactor temperature.
  """

  
  @doc """
  starts a reactor `core` and initiates core with max temperature
  tokens. The tokens represent number of times the core can go without
  venting gas until manual shutdown is required.
  
  Call from `user_connecting` or `awaiting_key_press` state?
  """
  def start_link(core, tokens \\ @aladin) do
    Agent.start_link(fn -> tokens end, name: core )
  end

  @doc """
  Checks current `core` temperature tokens
  """
  def core_check core do
    Agent.get(core, &(&1))
  end
  
  
  @doc """
  Removes a token from the `core`.
  """
  def doh core do
    Agent.get_and_update(core, fn
      [] -> {:error, []}
      [head|tail] -> {{:ok, head}, tail} end)
  end


  @doc """
  Venting gases releives pressure, cramps, and is fun to share with
  others. 

  Also, refills the 'core` token bucket, hureiy.
  """
  def vent_gas core, tokens \\ @aladin do
    Agent.update( core, fn [] -> tokens end)
  end
end
