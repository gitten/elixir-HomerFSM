defmodule HomerFSM.SrrmsFsm do
  use Fsm, initial_state: :user_connecting

  defstate user_connecting do
    defevent welcome_user do
      next_state(:awaiting_key_press)
    end
  end

  defstate awaiting_key_press do
    defevent any_key do
      next_state(:monitoring_core)
    end
  end

  defstate monitoring_core do
    defevent display_core_temp do
      IO.puts("Core Temp:fine")
    end
  end

  defstate awaiting_decision do
    defevent prompt do
      IO.puts("touchme")
    end
  end

  defstate venting_gas do
    defevent events do
      IO.puts
    end
  end

  defstate system_lock do
    defevent do
      IO.puts "manual restart required!?"
    end
  end
end
