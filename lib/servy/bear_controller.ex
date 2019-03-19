defmodule Servy.BearController do
  alias Servy.Conv
  alias Servy.Bear
  alias Servy.Wildthings

  import Servy.View, only: [render: 3]

  def index(%Conv{} = conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.sort_by_name(&1, &2))

    render(conv, "index.eex", bears: bears)
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    render(conv, "show.eex", bear: bear)
  end

  def new(%Conv{} = conv) do
  end

  def create(%Conv{} = conv, bear) do
    %{
      conv
      | status: 201,
        resp_body: "Created a #{bear["type"]} bear named #{bear["name"]}!"
    }
  end
end
