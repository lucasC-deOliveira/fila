defmodule Queue do
  use GenServer

  #Client
  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_link(initial_queue) when is_list(initial_queue) do
    GenServer.start_link(__MODULE__, initial_queue)
  end

  def stop(reason \\ :normal) do
    GenServer.stop(__MODULE__, reason)
  end

  def show() do
    GenServer.call(__MODULE__, :show_queue)
  end

  def enqueue(element) do
    GenServer.cast(__MODULE__, {:enqueue, element})
  end

  def dequeue() do
    GenServer.call(__MODULE__, :dequeue)
  end

  # Server
  @impl true
  def init(queue) do
    {:ok, queue}
  end

  @impl true
  def handle_cast({:enqueue, element}, queue) do
    new_queue = queue ++ [element]
    {:noreply, new_queue}
  end

  @impl true
  def handle_call(:dequeue, _from, []) do
    {:reply, :empty_queue, []}
  end

  @impl true
  def handle_call(:dequeue, _from, [element | new_queue]) do
    {:reply, element, new_queue}
  end

  @impl true
  def handle_call(:show_queue, _from, queue) do
    {:reply, queue, queue}
  end
end
