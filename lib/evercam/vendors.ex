defmodule Evercam.Vendors do
  alias Evercam.API

  def get_all_vendors do
    API.call(%{}, "/vendors", :get)
    |> API.handle_response
    |> received
  end

  def get_vendors_by_mac(mac_prefix) do
    API.call(%{}, "/vendors/#{mac_prefix}", :get)
    |> API.handle_response
    |> received
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"vendors" => vendors}, status_code, _headers}) do
    {:ok, vendors, status_code}
  end
end
