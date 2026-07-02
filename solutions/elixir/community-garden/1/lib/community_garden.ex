# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start() do
    Agent.start(fn -> %{last_id: 0, data: []} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.data end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      plot = %Plot{plot_id: state.last_id + 1, registered_to: register_to}
      {plot, %{last_id: plot.plot_id, data: [plot | state.data]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.get_and_update(pid, fn state ->
      case Enum.find_index(state.data, &(&1.plot_id == plot_id)) do
        nil -> {nil, state}
        index -> {:ok, %{last_id: state.last_id, data: List.delete_at(state.data, index)}}
      end
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      case Enum.find(state.data, &(&1.plot_id == plot_id)) do
        nil -> {:not_found, "plot is unregistered"}
        plot -> plot
      end
    end)
  end
end
