defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  defmodule Account do
    use GenServer

    @impl true
    def init(balance) do
      {:ok, %{open: true, balance: balance}}
    end

    @impl true
    def handle_call(_, _from, %{open: false} = state) do
      {:reply, {:error, :account_closed}, state}
    end

    def handle_call({_, amount}, _from, state) when is_number(amount) and amount < 0 do
      {:reply, {:error, :amount_must_be_positive}, state}
    end

    def handle_call(:balance, _from, %{balance: balance} = state) do
      {:reply, balance, state}
    end

    def handle_call({:deposit, amount}, _from, %{balance: balance} = state) do
      {:reply, :ok, %{state | balance: balance + amount}}
    end

    def handle_call({:withdraw, amount}, _from, %{balance: balance} = state)
        when amount > balance do
      {:reply, {:error, :not_enough_balance}, state}
    end

    def handle_call({:withdraw, amount}, _from, %{balance: balance} = state) do
      {:reply, :ok, %{state | balance: balance - amount}}
    end

    @impl true
    def handle_cast(:close, state) do
      {:noreply, %{state | open: false}}
    end
  end

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    with {:ok, pid} <- GenServer.start_link(Account, 0), do: pid
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    GenServer.cast(account, :close)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) do
    GenServer.call(account, {:deposit, amount})
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) do
    GenServer.call(account, {:withdraw, amount})
  end
end
