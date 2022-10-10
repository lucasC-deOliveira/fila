defmodule Fila do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Queue, [1, 2, 3]}
    ]

    opts = [strategy: :one_for_one, name: Queue.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
