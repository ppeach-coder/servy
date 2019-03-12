defmodule Servy.BearController do
  alias Servy.Conv
  alias Servy.Bear
  alias Servy.Wildthings

  def index(%Conv{} = conv) do
    items =
      Wildthings.list_bears()
      # |> Enum.filter(fn bear -> bear.type == "Grizzly" end)
      |> Enum.sort(&Bear.sort_by_name(&1, &2))
      |> Enum.map(&bear_item(&1))
      |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{conv | status: 200, resp_body: "<h1>#{bear.id}: #{bear.name}</h1>"}
  end

  def new(%Conv{} = conv) do
  end

  def create(%Conv{} = conv, bear) do
    %{
      conv
      | status: 201,
        resp_body: "Created a #{bear["type"]} bear named #{bear["name"]}"
    }
  end

  defp bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end
end