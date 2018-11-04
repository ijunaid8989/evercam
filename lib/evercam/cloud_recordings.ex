defmodule Evercam.CloudRecordings do
  alias Evercam.API

  def get_cloud_recordings(camera_id, client) do
    API.call(client, "/cameras/#{camera_id}/apps/cloud-recording", :get)
    |> API.handle_response
    |> received
  end

  defp received({:error, message, status_code, _headers}) do
    {:error, message, status_code}
  end
  defp received({:ok, %{"cloud_recordings" => cloud_recordings}, status_code, _headers}) do
    {:ok, cloud_recordings, status_code}
  end
end
