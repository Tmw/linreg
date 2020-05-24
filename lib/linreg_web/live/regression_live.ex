defmodule LinregWeb.RegressionLive do
  use LinregWeb, :live_view
  alias Linreg.{Data, Model}

  @impl true
  def mount(_params, _sesion, socket) do
    socket =
      socket
      |> assign(model: Linreg.Model.new())
      |> assign(data: Linreg.Data.new())
      |> assign(start_y: 0)
      |> assign(end_y: 0)

    {:ok, socket}
  end

  @impl true
  def handle_event("add_point", params, socket) do
    {:noreply, add_point(params, socket)}
  end

  defp add_point(%{"offsetX" => x, "offsetY" => y}, socket) do
    data =
      socket.assigns
      |> Map.get(:data)
      |> Data.add_point(map(x, 0, 800, 0, 1), map(y, 0, 800, 1, 0))

    socket
    |> assign(data: data)
    |> learn()
    |> update_prediction()
  end

  defp learn(%{assigns: %{data: data, model: model}} = socket) do
    if length(data.points) >= 2 do
      model = Model.train(model, data, learning_rate: 0.1, epochs: 500)
      assign(socket, model: model)
    else
      socket
    end
  end

  defp update_prediction(%{assigns: %{model: model}} = socket) do
    socket
    |> assign(start_y: Model.predict(model, 0))
    |> assign(end_y: Model.predict(model, 1))
  end
end
