defmodule HomerFSM.SrrmsFsm do
  use Fsm, initial_state: :user_connecting

  @moduledoc"""
  hrrrrrm
  """


  defstate user_connecting do
    defevent welcome_user do
      # some shnazzy loading/connecting anime here, someday
      IO.puts("Welcome, (something not funny).")

      HomerFSM.Reactor.start_link(:core)

      next_state(:awaiting_key_press)
    end
  end


  defstate awaiting_key_press do
    defevent any_key do
      IO.gets(
      """
      Press any key, then `Return`.

     ...or just press `Return`.
     """)
      # needs return after any key, so not really any key =(

      next_state(:monitoring_core)
    end
  end


  defstate monitoring_core do
    defevent display_core_temp do
      tokens = HomerFSM.Reactor.core_check |> Enum.count
      # `tokens` is place holder for temp for now
      IO.puts(
      """
      Core has #{tokens} tokens.
      """)
    end
    defevent prompt_user do
      #handling with a task for timeout
      task = Task.async(
        fn -> IO.gets("""
        The answer quickly
        """
        end))
# bookmark: left off here
      defp branch response do
        case response do
        end
      end
      
    end
    
  end


  defstate awaiting_decision do
    defevent prompt_user do
      IO.puts("touchme")
    end
  end


  defstate venting_gas do
    defevent some_events_here do
      IO.puts
    end
  end


  defstate system_lock do
    defevent lock do
      IO.puts "manual restart required!?"
    end
  end

end
