defmodule HomerFSMTest do
  use ExUnit.Case
  doctest HomerFSM

  @tokens [:token, :token]

  import HomerFSM.Reactor
  import HomerFSM.SrrmsFsm
  
  
  test "reactor module functionality" do
    start_link :core, [:token]

    assert {:ok, :token} == doh :core
    assert :error == doh :core

    vent_gas :core, @tokens
    assert @tokens == core_check :core
  end

end
