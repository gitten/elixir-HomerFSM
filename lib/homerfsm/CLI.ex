defmodule HomerFSM.CLI do
  @moduledoc """
  Command Line Interface for the Springfield Reactor Remote Monitoring
  System (SRRMS).
  """

  def run(argv) do
    argv
    |>parse_args
    
  end
  
  @doc """
  `argv` can be -h or --help, y/n, Y/N, or yes/no.

  -h and --help will return :help.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(
      argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> :help
      {[help: false], argv, _} -> argv
      _ -> :help
    end
  end
end

