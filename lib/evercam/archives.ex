defmodule Evercam.Archives do
  alias Evercam.API

  def get_archives(camera_id, client) do
    API.call(client, "/cameras/#{camera_id}/archives", :get)
    |> API.handle_response
    |> received
  end

  def get_archive(camera_id, archive_id, client) do
    API.call(client, "/cameras/#{camera_id}/archives/#{archive_id}", :get)
    |> API.handle_response
    |> received
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"archives" => archives}, status_code, _headers}) do
    {:ok, archives, status_code}
  end
end
