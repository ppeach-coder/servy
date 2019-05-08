defmodule Servy.KickStarter do
  use GenServer

  def start do
    IO.puts("Starting KickStarter...")
    GenServer.start(__MODULE__, :ok, name: __MODULE__)
  end

  def get_server do
    GenServer.call(__MODULE__, :get_server)
  end

  def init(:ok) do
    Process.flag(:trap_exit, true)
    http_server_pid = start_http_server()
    {:ok, http_server_pid}
  end

  def handle_call(:get_server, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:EXIT, _pid, reason}, _state) do
    IO.puts("HttpServer exited(#{inspect(reason)})")
    http_server_pid = start_http_server()
    {:noreply, http_server_pid}
  end

  defp start_http_server do
    IO.puts("Starting HTTP server...")
    http_server_pid = spawn_link(Servy.HttpServer, :start, [4000])
    Process.register(http_server_pid, :http_server)
    http_server_pid
  end
end
