defmodule Evercam.Models do
  alias Evercam.API

  def get_all_models do
    API.call(%{}, "/models", :get)
    |> API.handle_response
    |> received
  end

  def get_vendor_models(model_id) do
    API.call(%{}, "/models/#{model_id}", :get)
    |> API.handle_response
    |> received
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"models" => models}, status_code, _headers}) do
    {:ok, models, status_code}
  end
end