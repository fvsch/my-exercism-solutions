defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: d}) do
    "#{d} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%RemoteControlCar{battery_percentage: p}) do
    "Battery at #{p}%"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = car), do: car

  def drive(%RemoteControlCar{} = car) do
    %{
      car
      | battery_percentage: car.battery_percentage - 1,
        distance_driven_in_meters: car.distance_driven_in_meters + 20
    }
  end
end
