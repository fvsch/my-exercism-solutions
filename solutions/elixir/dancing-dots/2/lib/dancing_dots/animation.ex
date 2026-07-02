defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, opts()} | {:error, error()}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, number, _) when rem(number, 4) == 0, do: %{dot | opacity: dot.opacity / 2}
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    case Keyword.get(opts, :velocity) do
      value when is_number(value) -> {:ok, opts}
      value -> {:error, velocity_error(value)}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, number, opts) do
    inc = (number - 1) * Keyword.get(opts, :velocity, 1)
    %{dot | radius: dot.radius + inc}
  end

  defp velocity_error(value),
    do: "The :velocity option is required, and its value must be a number. Got: #{inspect(value)}"
end
