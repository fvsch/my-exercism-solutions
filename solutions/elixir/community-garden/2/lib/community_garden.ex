# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  @initial_state %{index: 0, plots: []}

  def start() do
    Agent.start(fn -> @initial_state end)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1.plots)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      plot = %Plot{plot_id: state.index + 1, registered_to: register_to}
      {plot, %{index: plot.plot_id, plots: [plot | state.plots]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.get_and_update(pid, fn %{plots: plots} = state ->
      case Enum.find_index(plots, &(&1.plot_id == plot_id)) do
        nil -> {nil, state}
        index -> {:ok, %{state | plots: List.delete_at(plots, index)}}
      end
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      Enum.find(
        plots,
        {:not_found, "plot is unregistered"},
        &(&1.plot_id == plot_id)
      )
    end)
  end
end
