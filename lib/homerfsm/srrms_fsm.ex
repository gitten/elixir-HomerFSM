defmodule HomerFSM.SrrmsFsm do
  use Fsm, initial_state: :user_connecting

  @moduledoc"""
  hrrrrrm
  """

  def connect do
    new
    |> welcome_user
    |> any_key
    |> tranny
  end

  def tranny next_state do
    case next_state do
      %{state: :monitoring_core} ->
        next_state
        |> display_core_temp
        |> prompt_user
        |> tranny
      %{state: :venting_gas} ->
        next_state
        |> vented
        |> woosh
        |> tranny
      %{state: :awaiting_decision} ->
        next_state
        |> prompt_user
        |> tranny
      %{state: :system_lock} ->
        next_state
        |> lock
    end
  end
  
  

  defstate user_connecting do
    defevent welcome_user do
      # some shnazzy loading/connecting anime here, someday
      IO.puts("\n\n\n\n\n\n")
      IO.puts("Welcome, (put something not funny).\n\n\n")

      HomerFSM.Reactor.start_link
      next_state(:awaiting_key_press)
    end
  end



  defstate awaiting_key_press do
    defevent any_key do

      IO.gets(
      """
      Press any key, then `Return`.
      
      ...or just press `Return`.\n\n
      """)
      # needs return after any key, so not really any key =(

      next_state(:monitoring_core)
    end
  end


  defstate monitoring_core do
    defevent display_core_temp do
      tokens = HomerFSM.Reactor.core_check
      |> Enum.count
      # `tokens` is place holder for temp for now
      IO.puts(
      """
      \n\nCore has #{tokens} tokens.
      
      """)
    end
    
    defevent prompt_user do
      tokens = HomerFSM.Reactor.core_check
      
      prompter(tokens) |> branch(:awaiting_decision, tokens)
      
    end
  end


  defstate awaiting_decision do
    defevent prompt_user do

      IO.puts "ADVISE: You want to vent.\n\n"
      
      prompter |> branch(:monitoring_core)

    end
  end


  defstate venting_gas do
    defevent vented do
      HomerFSM.Reactor.vent_gas
      IO.puts "\n\n\nplop, plop, fizz, fizz...\n"
    end

    defevent woosh do
      IO.puts "whats that smell...?\n"
      next_state(:monitoring_core)
    end
  end
    

  defstate system_lock do
    defevent lock do
      IO.puts "DOH! a manual restart required!\n"
      HomerFSM.Reactor.lock
    end
  end

  #######################################
  ## my privates

  defp branch response, state, tokens \\ nil do
    case {response, tokens} do

           {nil, []} -> next_state(:system_lock)
      {{:ok, "y\n"}, _} -> next_state(:venting_gas)

      {{:ok, "n\n"}, _} ->
        if state == :awaiting_decision do
        HomerFSM.Reactor.doh
        end
        next_state(state)

      {nil, _} ->
        HomerFSM.Reactor.doh
        next_state(:monitoring_core)
    end
  end


  defp prompter tokens \\ nil do
    case tokens do
      [] -> nil
      _ ->
        Task.async(IO, :gets, ["Would you like to vent gas? (`y` or `n`)_ "])
        |> Task.yield

    end
  end
end
